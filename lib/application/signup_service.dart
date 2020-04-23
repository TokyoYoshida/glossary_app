import 'dart:async';
import 'package:injectable/injectable.dart';
import 'package:glossaryapp/domain/login_user.dart';
import 'package:glossaryapp/infrastructure/cognito_service.dart';

abstract class SignupService {
  Future<SignupResult> signup(String email, String password);
  Future<bool> check_verification_code(String code);
  Future<bool> resendVerificationCode();
  Future<bool> isConfirmed();
}

@RegisterAs(SignupService)
@injectable
class SignupServiceImpl extends SignupService {
  LoginUser loginUser;
  SignupServiceImpl(this.loginUser);

  Future<SignupResult> signup(String email, String password) async {
    return loginUser.signup(email, password);
  }

  Future<bool> check_verification_code(String code) async {
    return loginUser.check_verification_code(code);
  }

  Future<bool> resendVerificationCode() async {
    return loginUser.resendVerificationCode();
  }

  Future<bool> isConfirmed() async {
    return loginUser.isConfirmed();
  }
}