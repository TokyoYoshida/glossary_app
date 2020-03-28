import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_login/flutter_login.dart';
import '../infrastructure/cognito_service.dart';
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

class LoginTopScreen extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: ChangeNotifierProvider(
            create: (context) => CounterStore(), child: LoginScreen()));
  }
}

class LoginScreen extends StatelessWidget {
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
      return null;
    });
  }

  Future<String> _signupUser(LoginData data) {
    print('Name: ${data.name}, Password: ${data.password}');
    return CognitoService.auth(data.name, data.name, data.password)
        .then((result) {
      print("success!");
      authMode = 2;
      return null;
    }).catchError((error) {
      print("authviewerror!" + error.toString());
      return extractErrorMessage(error.toString());
    });
  }

  String extractErrorMessage(String original) {
    final exp = RegExp(r'message: (.*)');
    var list =
        exp?.allMatches(original).map((match) => match.group(1)).toList();
    if (list.length == 1) {
      return list[0];
    }
    return "unknown error";
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

class MySignup extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: Form(
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
                          hintText: 'Enter your email',
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: RaisedButton(
                          onPressed: () {
                            // Validate will return true if the form is valid, or false if
                            // the form is invalid.
                            if (_formKey.currentState.validate()) {
                              // Process data.
                            }
                          },
                          child: Text('Submit'),
                        ),
                      ),
                    ],
                  ),
                )))));
  }
}
