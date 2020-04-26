import 'package:injectable/injectable.dart';

import 'package:glossaryapp/infrastructure/cognito_service.dart';

abstract class AbstractResult {
  String getDescription();
  bool isSuccess();
  bool isFailure() {
    return isSuccess();
  }
}

abstract class Result extends AbstractResult {
}

abstract class SignupResult extends AbstractResult {
  bool isUserNameExistsError();
}

abstract class LoginResult  extends AbstractResult {
  bool isNotConfirmedError();
}

abstract class LoginUser {
  String email;

  Future<SignupResult> signup(String email, String password);
  Future<Result> check_verification_code(String code);
  Future<bool> resendVerificationCode();
  Future<LoginResult> login(String email, String password);
  Future<bool> isConfirmed();
}

@RegisterAs(LoginUser)
@singleton
@injectable
class LoginUserImpl extends LoginUser {

  Future<SignupResult> signup(String email, String password) async {
    this.email = email;
    return await CognitoService.signup(email, email, password);
  }

  Future<Result> check_verification_code(String code) async {
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
