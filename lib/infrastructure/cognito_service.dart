import 'package:amazon_cognito_identity_dart/cognito.dart';
import 'dart:async';

import '../config/config.dart';
import '../global/result.dart';

class CognitoService {
  static String test() {
    CognitoService.auth(testUserEmail,testUserEmail,testUserPassword)
    .then((result) {
      print("success!");
    });
    print("authtest");
    return "test1";
  }

  static Future<SignupResult> auth(String name, String email, String password) async {
    final userPool = new CognitoUserPool(awsUserPoolId, awsClientId);
    final userAttributes = [
      new AttributeArg(name: 'name', value: name),
      new AttributeArg(name: 'email', value: email),
    ];

    var data;
    data = await userPool.signUp(email, password,
        userAttributes: userAttributes);
    return SignupResult.Success;
  }

  static Future<String> check_verification_code(String email, String input_code) async {
    final userPool = new CognitoUserPool(awsUserPoolId, awsClientId);

    final cognitoUser = new CognitoUser(
        email, userPool);

    bool registrationConfirmed = false;
    try {
      registrationConfirmed = await cognitoUser.confirmRegistration(input_code);
    } catch (e) {
      print(e);
    }
    print(registrationConfirmed);
  }
}