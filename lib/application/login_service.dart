import 'dart:async';
import 'package:injectable/injectable.dart';
import 'package:glossaryapp/domain/login_user.dart';

abstract class LoginService {
  Future<bool> login(String email, String password);
}

@RegisterAs(LoginService)
@injectable
class LoginServiceImpl extends LoginService {
  LoginUser loginUser;
  LoginServiceImpl(this.loginUser);

  Future<bool> login(String email, String password) async {
    return loginUser.login(email, password);
  }
}