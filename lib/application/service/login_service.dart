import 'dart:async';
import 'package:injectable/injectable.dart';
import 'package:glossaryapp/domain/model/user.dart';

abstract class LoginService {
  Future<LoginResult> login(String email, String password);
}

@RegisterAs(LoginService)
@injectable
class LoginServiceImpl extends LoginService {
  User loginUser;
  LoginServiceImpl(this.loginUser);

  Future<LoginResult> login(String email, String password) async {
    return loginUser.login(email, password);
  }
}