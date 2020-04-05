import 'package:injectable/injectable.dart';

import '../infrastructure/cognito_service.dart';

abstract class LoginUser {
  String email;

  Future<bool> signup(String email, String password);
  Future<bool> getVerificationCode();
  Future<bool> check_verification_code(String code);
  Future<bool> resendVerificationCode();
  Future<bool> login(String email, String password);
}

@RegisterAs(LoginUser)
@singleton
@injectable
class LoginUserImpl extends LoginUser {

  Future<bool> signup(String email, String password) async {
    this.email = email;
    return await CognitoService.auth(email, email, password);
  }

  Future<bool> getVerificationCode() async {
    return await CognitoService.getVerificationCode(this.email);
  }

  Future<bool> check_verification_code(String code) async {
    return await CognitoService.check_verification_code(this.email, code);
  }

  Future<bool> resendVerificationCode() async {
    return await CognitoService.resendVerificationCode(this.email);
  }

  Future<bool> login(String email, String password) async {
    this.email = email;
    return await CognitoService.login(email, email, password);
  }
}
