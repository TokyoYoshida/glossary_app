import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'dart:async';

import 'package:glossaryapp/generic_subdomain/model/user.dart';
import 'package:glossaryapp/application/service/signup_service.dart';
import 'package:glossaryapp/application/service/login_service.dart';

import 'package:flutter_login/flutter_login.dart';
import 'dart:async';

const users = const {
  'dribbble@gmail.com': '12345',
  'hunter@gmail.com': 'hunter',
};

@injectable
class LoginScreen extends StatelessWidget {
  SignupService signupService;
  LoginService loginService;

  LoginScreen(this.signupService, this.loginService);

  Duration get loginTime => Duration(milliseconds: 2250);
  bool needConfirm = false;

  Future<String> _login(LoginData data) {
    print('Name: ${data.name}, Password: ${data.password}');
    print(signupService);
    return loginService.login(data.name, data.password).then((result) {
      if (result.isSuccess()) {
        return "";
      }

      if (result.isNotConfirmedError()) {
        needConfirm = true;
        return "";
      }

      return result.getDescription();
    });
  }

  Future<String> signup(LoginData data, BuildContext context) {
    print('Name: ${data.name}, Password: ${data.password}');
    return signupService.signup(data.name, data.password).then((result) async {
      if (result.isSuccess()) {
        needConfirm = true;
        return "";
      }

      if (result.isUserNameExistsError()) {
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
        if (result == true) {
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
    return FlutterLogin(
      title: 'ECORP',
      logo: 'assets/images/ecorp-lightblue.png',
      onLogin: _login,
      onSignup: (loginData) {
        return signup(loginData, context);
      },
      onSubmitAnimationCompleted: () async {
        if (needConfirm) {
          Navigator.of(context).pushNamed('/verificationUser');
          return;
        }
        Navigator.of(context).pushNamed('/home');
      },
      onRecoverPassword: _recoverPassword,
    );
  }
}

