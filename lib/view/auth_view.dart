import 'package:flutter/material.dart';
import 'package:glossaryapp/application/error_message_service.dart';
import 'package:glossaryapp/application/signup_service.dart';
import 'package:injectable/injectable.dart';
import 'package:provider/provider.dart';

import 'package:flutter_login/flutter_login.dart';
import 'dart:async';

const users = const {
  'dribbble@gmail.com': '12345',
  'hunter@gmail.com': 'hunter',
};

class CounterStore with ChangeNotifier {
  var count = 0;

  void incrementCounter() {
    count++;
    notifyListeners();
  }
}

@injectable
class LoginTopScreen extends StatelessWidget {
  LoginScreen loginScreen;

  LoginTopScreen(this.loginScreen);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: ChangeNotifierProvider(
            create: (context) => CounterStore(), child: loginScreen));
  }
}

@injectable
class LoginScreen extends StatelessWidget {
  SignupService signupService;

  LoginScreen(this.signupService);

  Duration get loginTime => Duration(milliseconds: 2250);
  var authMode = 0;

  Future<String> _authUser(LoginData data) {
    print('Name: ${data.name}, Password: ${data.password}');
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(data.name)) {
        return 'Username not exists';
      }
      if (users[data.name] != data.password) {
        return 'Password does not match';
      }
      authMode = 1;
      return "success";
    });
  }

  Future<String> _signupUser(LoginData data) {
    print('Name: ${data.name}, Password: ${data.password}');
    return signupService.signup(data.name, data.password).then((result) {
      print("success!");
      authMode = 2;
      return null;
    }).catchError((error) {
      print("authviewerror!" + error.toString());
      return ErrorMessageService.extractFromError(error.toString());
    });
  }

  Future<String> _recoverPassword(String name) {
    print('Name: $name');
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(name)) {
        return 'Username not exists';
      }
      return null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CounterStore>(builder: (context, counterStore, _) {
      return FlutterLogin(
        title: 'ECORP',
        logo: 'assets/images/ecorp-lightblue.png',
        onLogin: _authUser,
        onSignup: _signupUser,
        onSubmitAnimationCompleted: () {
          if (authMode == 1) {
            Navigator.of(context).pushNamed('/afterlogin');
          } else {
            Navigator.of(context).pushNamed('/aftersingup');
          }
        },
        onRecoverPassword: _recoverPassword,
      );
    });
  }
}

class MyAuthTest extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new Scaffold(body: Text("login"));
  }
}

final _formKey = GlobalKey<FormState>();

@injectable
class MySignup extends StatelessWidget {
  SignupService signup_service;

  MySignup(this.signup_service);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: Builder(
            builder: (context) => Form(
                key: _formKey,
                child: new Container(
                    padding: const EdgeInsets.all(30.0),
                    color: Colors.white,
                    child: new Container(
                        child: new Center(
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          TextFormField(
                            decoration: const InputDecoration(
                              hintText: 'verification codeを入れてください。',
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter some code';
                              }
                              signup_service
                                  .check_verification_code(value)
                                  .then((result) {
                                return null;
                              }).catchError((error) {
                                return error.toString();
                              });
                              return null;
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: RaisedButton(
                              onPressed: () {
                                // Validate will return true if the form is valid, or false if
                                // the form is invalid.
                                print("press");
                                if (_formKey.currentState.validate()) {}
                              },
                              child: Text('確認する'),
                            ),
                          ),
                          RaisedButton(
                              child: Text('verification codeを再送する'),
                              onPressed: () {
                                if (this
                                        .signup_service
                                        .resendVerificationCode() != true) {
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                      content: Text(
                                          'verification codeの送信に失敗しました。')));
                                }
                              })
                        ],
                      ),
                    ))))));
  }

  void resendVerificationCode(BuildContext context) {
    if (this.signup_service.resendVerificationCode() != true) {
      Scaffold.of(context).showSnackBar(
          SnackBar(content: Text('verification codeの送信に失敗しました。')));
    }
  }
}
