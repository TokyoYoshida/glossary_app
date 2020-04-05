import 'package:injectable/injectable.dart';

import '../infrastructure/cognito_service.dart';
import '../global/result.dart';

abstract class LoginUser {
  String email;

  Future<Result> signup(String email, String password);
  Future<Result> check_verification_code(String code);
  Future<Result> resendVerificationCode();
}

@RegisterAs(LoginUser)
@singleton
@injectable
class LoginUserImpl extends LoginUser {


  Future<Result> signup(String email, String password) async {
    this.email = email;
    return await CognitoService.auth(email, email, password);
  }

  Future<Result> check_verification_code(String code) async {
    return await CognitoService.check_verification_code(this.email, code);
  }

  Future<Result> resendVerificationCode() async {
    return await CognitoService.resendVerificationCode(this.email);
  }
}
