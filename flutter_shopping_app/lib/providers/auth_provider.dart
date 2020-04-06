import 'dart:convert';
import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/http_exception.dart';
import 'package:http/http.dart' as http;
import '../constants.dart';

class FirebaseAuthResponse {
  final String idToken;
  final String email;
  final String refreshToken;
  final String expiresIn;
  final String localId;
  final String registered;

  FirebaseAuthResponse({
    this.idToken,
    this.email,
    this.refreshToken,
    this.expiresIn,
    this.localId,
    this.registered,
  });
}

class AuthProvider with ChangeNotifier {
  String _token;
  DateTime _expiryDatetime;
  String _userId;
  Timer _authTimer;

  bool get isAuthenticated {
    print('isauth: ${token != null}');
    return token != null;
  }

  String get token {
    if (_token != null &&
        _expiryDatetime != null &&
        _expiryDatetime.isAfter(DateTime.now())) {
      return _token;
    }

    return null;
  }

  String get userId {
    return _userId;
  }

  Future<void> _authenticate(
    String inputEmail,
    String inputPassword,
    String authUrl,
  ) async {
    try {
      final response = await http.post(
        authUrl,
        body: jsonEncode(
          {
            'email': inputEmail,
            'password': inputPassword,
            'returnSecureToken': true,
          },
        ),
      );

      // print(
      //     'login resp: ${response.statusCode}////\n ${jsonDecode(response.body)}');
      final responseMap = (jsonDecode(response.body) as Map<String, dynamic>);

      if (responseMap.containsKey('error')) {
        // even though status code is 200, if there is an 'error' key, there is a problem
        throw HttpException(responseMap['error']['message']);
      }

      _token = responseMap['idToken'];
      _userId = responseMap['localId'];
      _expiryDatetime = DateTime.now().add(
        Duration(
          seconds: int.parse(responseMap['expiresIn']),
        ),
      );

      _autoLogout();
      notifyListeners();

      final sharedPreferences = await SharedPreferences.getInstance();
      final userData = jsonEncode({
        'token': _token,
        'userId': _userId,
        'expiryDatetime': _expiryDatetime.toIso8601String(),
      });
      sharedPreferences.setString('userData', userData);
    } catch (exception) {
      throw exception;
    }
  }

  Future<bool> tryAutoLogin() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    if (!sharedPrefs.containsKey('userData')) {
      return false; // automatically wrapped in future coz of async
    }

    final extractedUserData =
        jsonDecode(sharedPrefs.get('userData')) as Map<String, Object>;
    final expiryDatetime = DateTime.parse(extractedUserData['expiryDatetime']);

    if (expiryDatetime.isBefore(DateTime.now())) {
      // token has expired
      return false;
    }

    _token = extractedUserData['token'];
    _userId = extractedUserData['userId'];
    _expiryDatetime = DateTime.parse(extractedUserData['expiryDatetime']);
    notifyListeners();
    _autoLogout();

    return true;
  }

  Future<void> signup(String inputEmail, String inputPassword) async {
    const signUpPostUrl = FIREBASE_EMAIL_PW_SIGNUP_URL + FIREBASE_WEB_API_KEY;

    return _authenticate(inputEmail, inputPassword, signUpPostUrl);
  }

  Future<void> login(String inputEmail, String inputPassword) async {
    const loginPostUrl = FIREBASE_EMAIL_PW_LOGIN_URL + FIREBASE_WEB_API_KEY;

    return _authenticate(inputEmail, inputPassword, loginPostUrl);
  }

  Future<void> logout() async {
    _token = null;
    _expiryDatetime = null;
    _userId = null;
    if (_authTimer != null) {
      _authTimer.cancel();
      _authTimer = null;
    }
    print('calling logout');
    notifyListeners();

    final sharedPrefs = await SharedPreferences.getInstance();
    //sharedPrefs.remove('userData'); // clears on userData
    sharedPrefs.clear(); // clears all-all app data
  }

  void _autoLogout() {
    if (_authTimer != null) {
      _authTimer.cancel(); // cancle existing timers
    }
    final timeToExpiryInSecs =
        _expiryDatetime.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(Duration(seconds: timeToExpiryInSecs), logout);
  }
}
