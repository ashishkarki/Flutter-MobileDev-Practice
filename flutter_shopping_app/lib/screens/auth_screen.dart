import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_shopping_app/screens/products_overview_screen.dart';
import 'package:provider/provider.dart';

import '../models/http_exception.dart';
import '../providers/auth_provider.dart';

enum AuthMode { Signup, Login }

class AuthScreen extends StatelessWidget {
  static const routeName = '/auth';

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    // final transformConfig = Matrix4.rotationZ(-8 * pi / 180);
    // transformConfig.translate(-10.0);
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(215, 117, 255, 1).withOpacity(0.5),
                  Color.fromRGBO(255, 188, 117, 1).withOpacity(0.9),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [0, 1],
              ),
            ),
          ),
          SingleChildScrollView(
            child: Container(
              height: deviceSize.height,
              width: deviceSize.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                    child: Container(
                      margin: EdgeInsets.only(bottom: 20.0),
                      padding:
                          EdgeInsets.symmetric(vertical: 8.0, horizontal: 74.0),
                      transform: Matrix4.rotationZ(-8 * pi / 180)
                        ..translate(-8.0, 12.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.deepOrange.shade900,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 8,
                            color: Colors.black26,
                            offset: Offset(0, 2),
                          )
                        ],
                      ),
                      child: Text(
                        'MyShop',
                        style: TextStyle(
                          color: Theme.of(context).accentTextTheme.title.color,
                          fontSize: 45,
                          fontFamily: 'Anton',
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: deviceSize.width > 600 ? 2 : 1,
                    child: AuthCard(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AuthCard extends StatefulWidget {
  const AuthCard({
    Key key,
  }) : super(key: key);

  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.Login;
  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };
  var _isLoading = false;
  final _passwordController = TextEditingController();
  AnimationController _animationCtrl;
  Animation<Offset> _slideAnimation;
  Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _animationCtrl = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );

    _slideAnimation = Tween<Offset>(
      begin: Offset(0, -1.5),
      end: Offset(0.0, 0.0),
    ).animate(
      CurvedAnimation(
        parent: _animationCtrl,
        curve: Curves.linear,
      ),
    );

    _opacityAnimation = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _animationCtrl,
        curve: Curves.easeInCirc,
      ),
    );
    // empty setState to trigger build method to update the screen when height changes
    // NOT NEEDED when using AnimationBuilder
    // _heightAnimation.addListener(
    //   () => setState(
    //     () {},
    //   ),
    // );

// not sure why, but without this, confirm password doesn't show up in signup mode
    _opacityAnimation.addStatusListener((_) {
      if (_authMode == AuthMode.Signup)
        _animationCtrl.forward();
      else if (_authMode == AuthMode.Login) _animationCtrl.reverse();
    });
  }

  @override
  void dispose() {
    super.dispose();

    _animationCtrl.dispose();
  }

  void _showErrorDialog(String message) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: Text('Some error occured!!'),
              content: Text(message),
              actions: <Widget>[
                FlatButton(
                  child: Text('Dismiss'),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ));
  }

  Future<void> _submit() async {
    if (!_formKey.currentState.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });

    final AuthProvider authProvider =
        Provider.of<AuthProvider>(context, listen: false);
    final navState = Navigator.of(context);

    try {
      if (_authMode == AuthMode.Login) {
        // Log user in
        await authProvider.login(
          _authData['email'],
          _authData['password'],
        );
      } else {
        // Sign user up
        await authProvider.signup(
          _authData['email'],
          _authData['password'],
        );
      }

      navState.pushReplacementNamed(ProductsOverviewScreen.routeName);
    } on HttpException catch (httpEx) {
      var errMsg = 'Failure!! ';
      final httpExStr = httpEx.toString();
      if (httpExStr.contains('EMAIL_EXISTS')) {
        errMsg += 'This email is already in use';
      } else if (httpExStr.contains("INVALID_EMAIL")) {
        errMsg += 'You have invalid email address';
      } else if (httpExStr.contains("WEAK_PASSWORD")) {
        errMsg += 'You have a weak password';
      } else {
        errMsg += 'Some HttpException happened!!';
      }

      _showErrorDialog(errMsg);
    } catch (generalException) {
      final errMsg =
          'Could not authenticate. Please try later. Your error message is ${generalException.toString()}';

      _showErrorDialog(errMsg);
    }

    setState(() {
      _isLoading = false;
    });
  }

  void _switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.Signup;
      });
      _animationCtrl.forward(); // required for FadeTransition
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });
    }
    _animationCtrl.reverse(); // required for FadeTransition
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 8.0,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
        height: _authMode == AuthMode.Signup ? 320 : 260,
        // height: _heightAnimation.value.height, // no need, animationCtrl does the animation
        constraints: BoxConstraints(
          minHeight: _authMode == AuthMode.Signup ? 320 : 260,
          // minHeight: _heightAnimation.value.height,
        ),
        width: deviceSize.width * 0.75,
        padding: EdgeInsets.all(16.0),
        child: Form(
          // this is passed back as 'animateBuilderChild' which doesn't get rebuilt
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(labelText: 'E-Mail'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value.isEmpty || !value.contains('@')) {
                      return 'Invalid email!';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _authData['email'] = value;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  controller: _passwordController,
                  validator: (value) {
                    if (value.isEmpty || value.length < 5) {
                      return 'Password is too short!';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _authData['password'] = value;
                  },
                ),
                // if (_authMode == AuthMode.Signup)
                AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  constraints: BoxConstraints(
                    minHeight: _authMode == AuthMode.Signup ? 60 : 0,
                    maxHeight: _authMode == AuthMode.Signup ? 120 : 0,
                  ),
                  curve: Curves.easeInCirc,
                  child: FadeTransition(
                    opacity: _opacityAnimation,
                    child: SlideTransition(
                      position: _slideAnimation,
                      child: TextFormField(
                        enabled: _authMode == AuthMode.Signup,
                        decoration:
                            InputDecoration(labelText: 'Confirm Password'),
                        obscureText: true,
                        validator: _authMode == AuthMode.Signup
                            ? (value) {
                                if (value != _passwordController.text) {
                                  return 'Passwords do not match!';
                                }
                                return null;
                              }
                            : null,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                if (_isLoading)
                  CircularProgressIndicator()
                else
                  RaisedButton(
                    child:
                        Text(_authMode == AuthMode.Login ? 'LOGIN' : 'SIGN UP'),
                    onPressed: _submit,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding:
                        EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
                    color: Theme.of(context).primaryColor,
                    textColor: Theme.of(context).primaryTextTheme.button.color,
                  ),
                FlatButton(
                  child: Text(
                      '${_authMode == AuthMode.Login ? 'SIGNUP' : 'LOGIN'} INSTEAD'),
                  onPressed: _switchAuthMode,
                  padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 4),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  textColor: Theme.of(context).primaryColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
