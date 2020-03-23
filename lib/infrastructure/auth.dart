import 'package:amazon_cognito_identity_dart/cognito.dart';
import 'dart:async';

import '../config/config.dart';

class AuthenticationService {
  static String test() {
    AuthenticationService.auth()
    .then((result) {
      print("success!");
    });
    print("authtest");
    return "test1";
  }

  static Future<String> auth() async {
    final userPool = new CognitoUserPool(awsUserPoolId, awsClientId);
    final userAttributes = [
      new AttributeArg(name: 'name', value: 'Jimmy'),
      new AttributeArg(name: 'email', value: testUserEmail),
    ];

    var data;
    try {
      data = await userPool.signUp(testUserEmail, testUserPassword,
          userAttributes: userAttributes);
      print("authtest success signup");
    } catch (e) {
      print(e);
      print("authtest error!" + e.toString());
    }
    return "success";
  }
}