import 'package:glossaryapp/domain/domain.dart';
import 'package:glossaryapp/domain/login_user.dart';

import '../infrastructure/cognito_service.dart';
import '../global/result.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

abstract class SignupService {
  Future<SignupResult> signup(String email, String password);
}

@RegisterAs(SignupService)
@injectable
class SignupServiceImpl extends SignupService {
  LoginUser loginUser;
  SignupServiceImpl(this.loginUser);

  Future<SignupResult> signup(String email, String password) async {
    return loginUser.signup(email, password);
  }
}