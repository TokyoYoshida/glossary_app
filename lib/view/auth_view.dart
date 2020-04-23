import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:provider/provider.dart';
import 'dart:async';

import 'package:glossaryapp/application/error_message_service.dart';
import 'package:glossaryapp/application/signup_service.dart';
import 'package:glossaryapp/application/login_service.dart';
import 'package:glossaryapp/infrastructure/cognito_service.dart';

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
  LoginService loginService;

  LoginScreen(this.signupService, this.loginService);

  Duration get loginTime => Duration(milliseconds: 2250);
  var authMode = 0;

  Future<String> _authUser(LoginData data) {
    print('Name: ${data.name}, Password: ${data.password}');
    print(signupService);
    return loginService.login(data.name, data.password).then((result) {
      if (result.isSuccess()) {
        authMode = 2;
        return "";
      }

      if (result.getCode() == LoginResultCode.NotConfirmedError) {
        authMode = 1;
        return "";
      }

      return result.getDescription();
    });
  }

  Future<String> _signupUser(LoginData data, BuildContext context) {
    print('Name: ${data.name}, Password: ${data.password}');
    return signupService.signup(data.name, data.password).then((result) async {
      if (result.isSuccess()) {
        authMode = 1;
        return "";
      }

      if (result.getCode() == SignupResultCode.UsernameExistsError) {
        var result = await showDialog<bool>(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('すでに登録済です'),
              content: Text('このままログインしますか？'),
              actions: <Widget>[
                FlatButton(
                  child: Text('いいえ'),
                  onPressed: () => Navigator.of(context).pop(false),
                ),
                FlatButton(
                  child: Text('はい'),
                  onPressed: () => Navigator.of(context).pop(true),
                ),
              ],
            );
          },
        );
        if (result == true){
          return "";
        }
      }

      return result.getDescription();
    });
  }

  Future<String> _recoverPassword(String name) {
    print('Name: $name');
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(name)) {
        return 'Username not exists';
      }
      return "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CounterStore>(builder: (context, counterStore, _) {
      return FlutterLogin(
        title: 'ECORP',
        logo: 'assets/images/ecorp-lightblue.png',
        onLogin: _authUser,
        onSignup: (loginData) {
          return _signupUser(loginData, context);
        },
        onSubmitAnimationCompleted: () async {
          if (authMode == 1) {
            Navigator.of(context).pushNamed('/checkVerificationCode');
          }
          Navigator.of(context).pushNamed('/home');
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
class MySignup extends StatefulWidget {
  SignupService signup_service;
  MySignup(this.signup_service);

  @override
  MySignupState createState() => MySignupState(this.signup_service);
}


@injectable
class MySignupState extends State<MySignup> {
  SignupService signup_service;
  final verificationCodeTextController = TextEditingController();
  String validatorResult;

  MySignupState(this.signup_service);

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
                            controller: verificationCodeTextController,
                            decoration: const InputDecoration(
                              hintText: 'verification codeを入れてください。',
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter some code';
                              }
                              return this.validatorResult;
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: RaisedButton(
                              onPressed: () async {
                                // Validate will return true if the form is valid, or false if
                                // the form is invalid.
                                signup_service
                                    .check_verification_code(verificationCodeTextController.text)
                                    .then((result) {
                                  Navigator.of(context).pushNamed('/home');
                                }).catchError((error) {
                                  var err =  ErrorMessageService.extractFromError(error.toString());
                                  setState(() {
                                    print(err);
                                    this.validatorResult = "失敗しました。";
                                  });
                                });
                                if (_formKey.currentState.validate()) {}
                              },
                              child: Text('送信する'),
                            ),
                          ),
                          RaisedButton(
                              child: Text('verification codeを再送する'),
                              onPressed: () => CommonView.resendVerificationCode(context, signup_service)
                              )
                        ],
                      ),
                    ))))));
  }
}

class CommonView {
  static void resendVerificationCode(BuildContext context, SignupService signup_service) {
    signup_service
        .resendVerificationCode().then((result) {
      print("success!");
      Scaffold.of(context).showSnackBar(SnackBar(
          content: Text(
              'verification codeを送信しました。')));
    }).catchError((error) {
      print("authviewerror!" + error.toString());
      Scaffold.of(context).showSnackBar(SnackBar(
          content: Text(
              'verification codeに失敗しました。')));
    });
  }
}