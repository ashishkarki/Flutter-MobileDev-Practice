import 'dart:convert';

import 'package:flutter/widgets.dart';

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

  bool get isAuthenticated {
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
      print('responseMap: $responseMap');
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

      notifyListeners();
    } catch (exception) {
      throw exception;
    }
  }

  Future<void> signup(String inputEmail, String inputPassword) async {
    const signUpPostUrl = FIREBASE_EMAIL_PW_SIGNUP_URL + FIREBASE_WEB_API_KEY;

    return _authenticate(inputEmail, inputPassword, signUpPostUrl);
  }

  Future<void> login(String inputEmail, String inputPassword) async {
    const loginPostUrl = FIREBASE_EMAIL_PW_LOGIN_URL + FIREBASE_WEB_API_KEY;

    return _authenticate(inputEmail, inputPassword, loginPostUrl);
  }
}
