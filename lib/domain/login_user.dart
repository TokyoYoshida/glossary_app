import '../infrastructure/cognito_service.dart';
import '../global/result.dart';

abstract class LoginUser {
  Future<SignupResult> signup(String email, String password);
}

class LoginUserImpl extends LoginUser {
  static final LoginUserImpl _singleton = new LoginUserImpl._internal();

  factory LoginUserImpl() {
    return _singleton;
  }

  LoginUserImpl._internal();

  Future<SignupResult> signup(String email, String password) async {
    return await CognitoService.auth(email, email, password);
  }
}
