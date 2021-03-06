import 'package:amazon_cognito_identity_dart/cognito.dart';
import 'package:glossaryapp/domain/generic_subdomain/interface/login_session.dart';
import 'package:glossaryapp/infrastructure/result/signup_result.dart';
import 'package:glossaryapp/infrastructure/result/login_result.dart';
import 'package:glossaryapp/infrastructure/result/result.dart';
import 'package:glossaryapp/infrastructure/session/api_session.dart';
import 'package:injectable/injectable.dart';
import 'dart:async';
import 'package:glossaryapp/config/config.dart';

class CognitoSession {
}

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

class CognitoSignupResult extends CognitoResult implements SignupResult {

  CognitoSignupResult(code, description) : super(code ,description);
  CognitoSignupResult.Exception(exception) : super.Exception(exception);
  CognitoSignupResult.Success() : super.Success();

  bool isUserNameExistsError() {
    return _code == "UsernameExistsException";
  }
}

class CognitoLoginResult extends CognitoResult implements LoginResult {
  CognitoApiSessionSupplier _sessionSupplier;

  CognitoLoginResult(code, description) : super(code ,description);
  CognitoLoginResult.Exception(exception) : super.Exception(exception);
  CognitoLoginResult.Success(CognitoUserSession session) : super.Success() {
    _sessionSupplier = CognitoApiSessionSupplier(session);
  }

  bool isNotConfirmedError() {
    return _code == "UserNotConfirmedException";
  }

  ApiSessionSupplier getSessionSupplier() {
    return _sessionSupplier;
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

@singleton
@injectable
class CognitoAuthService {
  Future<CognitoSignupResult> signup(String name, String email, String password) async {
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

  Future<CognitoVerificationUserResult> verificationUser(String email, String code) async {
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

  Future<bool> resendVerificationCode(String email) async {
    final userPool = new CognitoUserPool(awsUserPoolId, awsClientId);

    final cognitoUser = new CognitoUser(
        email, userPool);

    var status;

    status = await cognitoUser.resendConfirmationCode();
    print(status);

    return true;
  }

  Future<List<CognitoUserAttribute>> getUserInfo(String email) async {
    final userPool = new CognitoUserPool(awsUserPoolId, awsClientId);

    final cognitoUser = new CognitoUser(
        email, userPool);

    List<CognitoUserAttribute> attributes = await cognitoUser.getUserAttributes();

    print(attributes);

    return attributes;
  }

  Future<CognitoLoginResult> login(String name, String password) async {
    final userPool = new CognitoUserPool(awsUserPoolId, awsClientId);
    final cognitoUser = new CognitoUser(
        name, userPool);
    final authDetails = new AuthenticationDetails(
        username: name, password: password);

    CognitoUserSession session;
    try {
      session = await cognitoUser.authenticateUser(authDetails);
    } catch (e) {
      return CognitoLoginResult.Exception(e);
    }

    return CognitoLoginResult.Success(session);
  }
}

