import 'package:injectable/injectable.dart';

import 'package:glossaryapp/infrastructure/authontication/cognito_service.dart';

abstract class AbstractResult {
  String getDescription();
  bool isSuccess();
  bool isFailure() {
    return !isSuccess();
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

abstract class VerificationUserResult  extends AbstractResult {
  bool isCodeMismatch();
}

@RegisterAs(User)
@singleton
@injectable
class User {
  String userId;
  String email;

  Future<bool> isConfirmed() async {
    return await CognitoService.isConfirmed(this.email);
  }
}

@RegisterAs(LoginSession)
@singleton
@injectable
class LoginSession {
}

class Authentication {
  Future<LoginResult> login(String email, String password) async {
    return await CognitoService.login(email, password);
  }
}

class Signup {
  Future<SignupResult> signup(String userId, String email, String password) async {
    return await CognitoService.signup(userId, email, password);
  }
}

class Verification {
  Future<VerificationUserResult> verificationUser(String email, String code) async {
    return await CognitoService.verificationUser(email, code);
  }

  Future<bool> resendVerificationCode(String email) async {
    return await CognitoService.resendVerificationCode(email);
  }
}
