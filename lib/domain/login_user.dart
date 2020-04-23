import 'package:injectable/injectable.dart';

import 'package:glossaryapp/infrastructure/cognito_service.dart';

enum SignupResultCode {
  Success,
  UsernameExistsError,
  UnknownError
}

abstract class SignupResult {
  SignupResultCode getCode();
  String getDescription();
  bool isSuccess();
}

enum LoginResultCode {
  Success,
  NotConfirmedError,
  UnknownError
}

abstract class LoginResult {
  LoginResultCode getCode();

  String getDescription();

  bool isSuccess();
}

abstract class LoginUser {
  String email;

  Future<SignupResult> signup(String email, String password);
  Future<bool> check_verification_code(String code);
  Future<bool> resendVerificationCode();
  Future<LoginResult> login(String email, String password);
  Future<bool> isConfirmed();
}

enum LoginUserStatus {
  UnSignup,
  UnConfirm,
  LoggedIn
}

@RegisterAs(LoginUser)
@singleton
@injectable
class LoginUserImpl extends LoginUser {

  Future<SignupResult> signup(String email, String password) async {
    this.email = email;
    return await CognitoService.signup(email, email, password);
  }

  Future<bool> check_verification_code(String code) async {
    return await CognitoService.check_verification_code(this.email, code);
  }

  Future<bool> resendVerificationCode() async {
    return await CognitoService.resendVerificationCode(this.email);
  }

  Future<bool> isConfirmed() async {
    return await CognitoService.isConfirmed(this.email);
  }

  Future<LoginResult> login(String email, String password) async {
    this.email = email;

    return await CognitoService.login(email, password);
  }
}
