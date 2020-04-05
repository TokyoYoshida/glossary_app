import 'package:amazon_cognito_identity_dart/cognito.dart';
import 'package:injectable/injectable.dart';
import 'dart:async';

import '../config/config.dart';
import '../global/result.dart';

@injectable
class CognitoService {
  static String test() {
    CognitoService.auth(testUserEmail,testUserEmail,testUserPassword)
    .then((result) {
      print("success!");
    });
    print("authtest");
    return "test1";
  }

  static Future<Result> auth(String name, String email, String password) async {
    final userPool = new CognitoUserPool(awsUserPoolId, awsClientId);
    final userAttributes = [
      new AttributeArg(name: 'name', value: name),
      new AttributeArg(name: 'email', value: email),
    ];

    await userPool.signUp(email, password,
        userAttributes: userAttributes);

    return Result.Success;
  }

  static Future<Result> check_verification_code(String email, String code) async {
    final userPool = new CognitoUserPool(awsUserPoolId, awsClientId);

    final cognitoUser = new CognitoUser(
        email, userPool);

    await cognitoUser.confirmRegistration(code);

    return Result.Success;
  }

  static Future<Result> resendVerificationCode(String email) async {
    final userPool = new CognitoUserPool(awsUserPoolId, awsClientId);

    final cognitoUser = new CognitoUser(
        email, userPool);

    var status;

    status = await cognitoUser.resendConfirmationCode();
    print(status);

    return Result.Success;
  }
}
