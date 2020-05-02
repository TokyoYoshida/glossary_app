import 'package:amazon_cognito_identity_dart/cognito.dart';
import 'package:glossaryapp/generic_subdomain/interface/login_session.dart';
import 'package:glossaryapp/infrastructure/result/signup_result.dart';
import 'package:glossaryapp/infrastructure/result/login_result.dart';
import 'package:glossaryapp/infrastructure/result/result.dart';
import 'package:injectable/injectable.dart';
import 'dart:async';

import 'package:glossaryapp/config/config.dart';


abstract class VerificationUserResult  extends AbstractResult {
  bool isCodeMismatch();
}

class CognitoExceptionDescriptionService {
  static String get(Exception exception) {
    if(exception is CognitoClientException) {
      return (exception as CognitoClientException).message;
    }
    return exception.toString();
  }
}

class CognitoResult extends AbstractResult implements Result {
  static const String codeSuccess = "success";
  static const String descriptionSuccess = "success";
  String _code;
  String _description;

  CognitoResult(this._code, this._description);

  CognitoResult.Exception(Exception exception) {
    _code = buildCode(exception);
    _description =
        CognitoExceptionDescriptionService.get(exception);
  }

  CognitoResult.Success() {
    _code = codeSuccess;
    _description = descriptionSuccess;
  }

  String buildCode(Exception exception) {
    if (exception is CognitoClientException) {
      return exception.code;
    }
    return null;
  }

  String getDescription() {
    return _description;
  }

  bool isSuccess() {
    return _code == codeSuccess;
  }
}

class CognitoSignupResult extends CognitoResult implements SignupResult, LoginSessionGeneratable {
  LoginSession session;

  CognitoSignupResult(code, description) : super(code ,description);
  CognitoSignupResult.Exception(exception) : super.Exception(exception);
  CognitoSignupResult.Success(this.session) : super.Success();

  bool isUserNameExistsError() {
    return _code == "UsernameExistsException";
  }

  LoginSession getLoginSession() {
    return session;
  }
}

class CognitoLoginResult extends CognitoResult implements LoginResult, LoginSessionGeneratable {
  LoginSession session;

  CognitoLoginResult(code, description) : super(code ,description);
  CognitoLoginResult.Exception(exception) : super.Exception(exception);
  CognitoLoginResult.Success(this.session) : super.Success();

  bool isNotConfirmedError() {
    return _code == "UserNotConfirmedException";
  }

  LoginSession getLoginSession() {
    return session;
  }
}

class CognitoVerificationUserResult extends CognitoResult implements VerificationUserResult {
  CognitoVerificationUserResult(code, description) : super(code ,description);
  CognitoVerificationUserResult.Exception(exception) : super.Exception(exception);
  CognitoVerificationUserResult.Success() : super.Success();

  bool isCodeMismatch() {
    return _code == "CodeMismatchException";
  }
}

@injectable
class CognitoService {
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

    return CognitoSignupResult.Success(CognitoLoginSession());
  }

  static Future<CognitoVerificationUserResult> verificationUser(String email, String code) async {
    final userPool = new CognitoUserPool(awsUserPoolId, awsClientId);

    final cognitoUser = new CognitoUser(
        email, userPool);

    try {
      await cognitoUser.confirmRegistration(code);
    } catch (e) {
      return CognitoVerificationUserResult.Exception(e);
    }

    return CognitoVerificationUserResult.Success();
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

    return CognitoLoginResult.Success(CognitoLoginSession());
  }
}

class CognitoLoginSession extends LoginSession {

}