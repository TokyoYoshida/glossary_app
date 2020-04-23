import 'package:amazon_cognito_identity_dart/cognito.dart';
import 'package:glossaryapp/domain/login_user.dart';
import 'package:injectable/injectable.dart';
import 'dart:async';

import 'package:glossaryapp/config/config.dart';

class CognitoExceptionDescriptionService {
  static String get(Exception exception) {
    if(exception is CognitoClientException) {
      return (exception as CognitoClientException).message;
    }
    return exception.toString();
  }
}

class CognitoSignupResult implements SignupResult {
  SignupResultCode _code;
  String _description;

  CognitoSignupResult(this._code, this._description);

  CognitoSignupResult.Exception(Exception exception) {
    _code = buildCode(exception);
    _description =
        CognitoExceptionDescriptionService.get(exception);
  }

  factory CognitoSignupResult.Success() {
    return CognitoSignupResult(SignupResultCode.Success, "success");
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

class CognitoLoginResult implements LoginResult {
  LoginResultCode _code;
  String _description;

  CognitoLoginResult(this._code, this._description);

  CognitoLoginResult.Exception(Exception exception) {
    _code = buildCode(exception);
    _description =
        CognitoExceptionDescriptionService.get(exception);
  }

  factory CognitoLoginResult.Success() {
    return CognitoLoginResult(LoginResultCode.Success, "success");
  }

  LoginResultCode buildCode(Exception exception) {
    if (exception is CognitoClientException && exception.code == "UserNotConfirmedException") {
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
    return _code == LoginResultCode.Success;
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

  static Future<CognitoSignupResult> signup(String name, String email, String password) async {
    final userPool = new CognitoUserPool(awsUserPoolId, awsClientId);
    final userAttributes = [
      new AttributeArg(name: 'name', value: name),
      new AttributeArg(name: 'email', value: email),
    ];

    try {
      await userPool.signUp(email, password,
          userAttributes: userAttributes);
    } catch (e) {
      return CognitoSignupResult.Exception(e);
    }

    return CognitoSignupResult.Success();
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

  static Future<CognitoLoginResult> login(String name, String password) async {
    final userPool = new CognitoUserPool(awsUserPoolId, awsClientId);
    final cognitoUser = new CognitoUser(
        name, userPool);
    final authDetails = new AuthenticationDetails(
        username: name, password: password);

    try {
      CognitoUserSession session = await cognitoUser.authenticateUser(authDetails);
    } catch (e) {
      return CognitoLoginResult.Exception(e);
    }

    return CognitoLoginResult.Success();
  }
}
