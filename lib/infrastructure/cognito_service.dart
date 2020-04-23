import 'package:amazon_cognito_identity_dart/cognito.dart';
import 'package:injectable/injectable.dart';
import 'dart:async';

import 'package:glossaryapp/config/config.dart';

class CognitoErrorMessageService {
  static String extractFromError(String original) {
    final exp = RegExp(r'message: ([^}]*)');
    var list =
    exp?.allMatches(original).map((match) => match.group(1)).toList();
    if (list.length == 1) {
      return list[0];
    }
    return "unknown error";
  }
}
enum SignupResultCode {
  Success,
  UsernameExistsError,
  UnknownError
}

class SignupResult {
  SignupResultCode _code;
  String _description;

  SignupResult(this._code, this._description);

  SignupResult.Exception(Exception exception) {
    _code = buildCode(exception);
    _description =
        CognitoErrorMessageService.extractFromError(exception.toString());
  }

  factory SignupResult.Success() {
    return SignupResult(SignupResultCode.Success, "success");
  }

  SignupResultCode buildCode(Exception exception) {
    if (exception is CognitoClientException &&
        exception.code == "UsernameExistsException") {
      return SignupResultCode.UsernameExistsError;
    }
    return SignupResultCode.UnknownError;
  }

  SignupResultCode getCode() {
    return _code;
  }

  String getDescription() {
    return _description;
  }

  bool isSuccess() {
    return _code == SignupResultCode.Success;
  }
}

enum LoginResultCode {
  Success,
  NotConfirmedError,
  UnknownError
}

class LoginResult {
  LoginResultCode _code;
  String _description;

  LoginResult(this._code, this._description);

  LoginResult.Exception(Exception exception) {
    _code = buildCode(exception);
    _description =
        CognitoErrorMessageService.extractFromError(exception.toString());
  }

  factory LoginResult.Success() {
    return LoginResult(LoginResultCode.Success, "success");
  }

  LoginResultCode buildCode(Exception exception) {
    if (exception is CognitoUserConfirmationNecessaryException){
      return LoginResultCode.NotConfirmedError;
    }
    return LoginResultCode.UnknownError;
  }

  LoginResultCode getCode() {
    return _code;
  }

  String getDescription() {
    return _description;
  }

  bool isSuccess() {
    return _code == SignupResultCode.Success;
  }
}

@injectable
class CognitoService {
  static String test() {
    CognitoService.signup(testUserEmail,testUserEmail,testUserPassword)
    .then((result) {
      print("success!");
    });
    print("authtest");
    return "test1";
  }

  static Future<SignupResult> signup(String name, String email, String password) async {
    final userPool = new CognitoUserPool(awsUserPoolId, awsClientId);
    final userAttributes = [
      new AttributeArg(name: 'name', value: name),
      new AttributeArg(name: 'email', value: email),
    ];

    try {
      await userPool.signUp(email, password,
          userAttributes: userAttributes);
    } catch (e) {
      return SignupResult.Exception(e);
    }

    return SignupResult.Success();
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

  static Future<bool> isConfirmed(String email) async {
    List<CognitoUserAttribute> attr = await CognitoService.getUserInfo(email);
    return true;
  }

  static Future<List<CognitoUserAttribute>> getUserInfo(String email) async {
    final userPool = new CognitoUserPool(awsUserPoolId, awsClientId);

    final cognitoUser = new CognitoUser(
        email, userPool);

    List<CognitoUserAttribute> attributes = await cognitoUser.getUserAttributes();

    print(attributes);

    return attributes;
  }

  static Future<LoginResult> login(String name, String password) async {
    final userPool = new CognitoUserPool(awsUserPoolId, awsClientId);
    final cognitoUser = new CognitoUser(
        name, userPool);
    final authDetails = new AuthenticationDetails(
        username: name, password: password);

    try {
      CognitoUserSession session = await cognitoUser.authenticateUser(authDetails);
    } catch (e) {
      return LoginResult.Exception(e);
    }

    return LoginResult.Success();
  }
}
