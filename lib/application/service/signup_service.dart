import 'dart:async';
import 'package:injectable/injectable.dart';
import 'package:glossaryapp/domain/model/user.dart';

abstract class SignupService {
  Future<SignupResult> signup(String email, String password);
  Future<VerificationUserResult> verificationUser(String code);
  Future<bool> resendVerificationCode();
  Future<bool> isConfirmed();
}

@RegisterAs(SignupService)
@injectable
class SignupServiceImpl extends SignupService {
  User loginUser;
  SignupServiceImpl(this.loginUser);

  Future<SignupResult> signup(String email, String password) async {
    return loginUser.signup(email, password);
  }

  Future<VerificationUserResult> verificationUser(String code) async {
    return loginUser.verificationUser(code);
  }

  Future<bool> resendVerificationCode() async {
    return loginUser.resendVerificationCode();
  }

  Future<bool> isConfirmed() async {
    return loginUser.isConfirmed();
  }
}