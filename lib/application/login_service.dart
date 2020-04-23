import 'dart:async';
import 'package:injectable/injectable.dart';
import 'package:glossaryapp/domain/login_user.dart';
import 'package:glossaryapp/infrastructure/cognito_service.dart';

abstract class LoginService {
  Future<LoginResult> login(String email, String password);
}

@RegisterAs(LoginService)
@injectable
class LoginServiceImpl extends LoginService {
  LoginUser loginUser;
  LoginServiceImpl(this.loginUser);

  Future<LoginResult> login(String email, String password) async {
    return loginUser.login(email, password);
  }
}