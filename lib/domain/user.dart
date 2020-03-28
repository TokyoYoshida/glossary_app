import '../infrastructure/cognito_service.dart';
import '../global/result.dart';

abstract class LoginUser {
  Future<SignupResult> signup(String name, String email, String password) async;
}

class LoginUserImpl extends LoginUser {
  static final LoginUserImpl _singleton = new LoginUserImpl._internal();

  factory LoginUserImpl() {
    return _singleton;
  }

  LoginUserImpl._internal();

  Future<SignupResult> signup(String name, String email, String password) async {
    return await CognitoService.auth(name, email, password);
  }
}
