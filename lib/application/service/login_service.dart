import 'dart:async';
import 'package:injectable/injectable.dart';
import 'package:glossaryapp/generic_subdomain/model/user.dart';
import 'package:glossaryapp/infrastructure/result/login_result.dart';
import 'package:glossaryapp/application/repository/login_session_repository.dart';
import 'package:glossaryapp/application/repository/user_repository.dart';
import 'package:glossaryapp/infrastructure/authontication/cognito_service.dart';

abstract class LoginService {
  Future<LoginResult> login(String email, String password);
}

@RegisterAs(LoginService)
@injectable
class LoginServiceImpl extends LoginService {
  UserRepository userRepo;
  LoginSessionRepository sessionRepo;
  LoginServiceImpl(this.userRepo, this.sessionRepo);

  Future<LoginResult> login(String email, String password) async {
    var result = await CognitoService.login(email, password);

    var session = result.getLoginSession();
    var user = userRepo.getByEmail(email);
    session.setLoginUser(user);
    sessionRepo.store(session);

    return result;
  }
}