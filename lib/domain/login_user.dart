import 'package:injectable/injectable.dart';

import '../infrastructure/cognito_service.dart';
import '../global/result.dart';

abstract class LoginUser {
  Future<SignupResult> signup(String email, String password);
}

@RegisterAs(LoginUser)
@singleton
@injectable
class LoginUserImpl extends LoginUser {
  Future<SignupResult> signup(String email, String password) async {
    return await CognitoService.auth(email, email, password);
  }
}
