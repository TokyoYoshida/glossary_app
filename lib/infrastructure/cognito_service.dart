import 'package:amazon_cognito_identity_dart/cognito.dart';
import 'dart:async';

import '../config/config.dart';

class CognitoService {
  static String test() {
    CognitoService.auth(testUserEmail,testUserEmail,testUserPassword)
    .then((result) {
      print("success!");
    });
    print("authtest");
    return "test1";
  }

  static Future<String> auth(String name, String email, String password) async {
    final userPool = new CognitoUserPool(awsUserPoolId, awsClientId);
    final userAttributes = [
      new AttributeArg(name: 'name', value: name),
      new AttributeArg(name: 'email', value: email),
    ];

    var data;
    try {
      data = await userPool.signUp(email, password,
          userAttributes: userAttributes);
      print("authtest success signup");
    } catch (e) {
      print(e);
      print("authtest error!" + e.toString());
    }
    return "success";
  }
}