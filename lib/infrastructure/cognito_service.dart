import 'package:amazon_cognito_identity_dart/cognito.dart';
import 'package:injectable/injectable.dart';
import 'dart:async';

import '../config/config.dart';

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

  static Future<bool> auth(String name, String email, String password) async {
    final userPool = new CognitoUserPool(awsUserPoolId, awsClientId);
    final userAttributes = [
      new AttributeArg(name: 'name', value: name),
      new AttributeArg(name: 'email', value: email),
    ];

    await userPool.signUp(email, password,
        userAttributes: userAttributes);

    return true;
  }

  static Future<bool> check_verification_code(String email, String code) async {
    final userPool = new CognitoUserPool(awsUserPoolId, awsClientId);

    final cognitoUser = new CognitoUser(
        email, userPool);

    await cognitoUser.confirmRegistration(code);

    return true;
  }

  static Future<bool> resendVerificationCode(String email) async {
    final userPool = new CognitoUserPool(awsUserPoolId, awsClientId);

    final cognitoUser = new CognitoUser(
        email, userPool);

    var status;

    status = await cognitoUser.resendConfirmationCode();
    print(status);

    return true;
  }

  static Future<bool> login(String name, String password) async {
    final userPool = new CognitoUserPool(awsUserPoolId, awsClientId);
    final cognitoUser = new CognitoUser(
        'email@inspire.my', userPool);
    final authDetails = new AuthenticationDetails(
        username: name, password: password);

    CognitoUserSession session;

    session = await cognitoUser.authenticateUser(authDetails);

    print(session.getAccessToken().getJwtToken());

    return true;
  }
}
