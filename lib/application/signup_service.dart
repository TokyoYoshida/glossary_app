import 'dart:async';
import 'package:injectable/injectable.dart';
import 'package:glossaryapp/domain/login_user.dart';

abstract class SignupService {
  Future<bool> signup(String email, String password);
}

@RegisterAs(SignupService)
@injectable
class SignupServiceImpl extends SignupService {
  LoginUser loginUser;
  SignupServiceImpl(this.loginUser);

  Future<bool> signup(String email, String password) async {
    return loginUser.signup(email, password);
  }
}