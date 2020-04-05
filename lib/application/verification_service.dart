import 'dart:async';
import 'package:injectable/injectable.dart';
import 'package:glossaryapp/domain/login_user.dart';

abstract class VerificationService {
  Future<bool> isNeedVerification();
  Future<bool> check_verification_code(String code);
  Future<bool> resendVerificationCode();
}

@RegisterAs(VerificationService)
@injectable
class VerificationServiceImpl extends VerificationService {
  LoginUser loginUser;
  VerificationServiceImpl(this.loginUser);

  Future<bool> isNeedVerification() async {
    print("thisisstest");
    print(await loginUser.getVerificationCode());
  }

  Future<bool> check_verification_code(String code) async {
    return loginUser.check_verification_code(code);
  }

  Future<bool> resendVerificationCode() async {
    return loginUser.resendVerificationCode();
  }
}