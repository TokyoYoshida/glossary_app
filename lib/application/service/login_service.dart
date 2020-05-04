import 'dart:async';
import 'package:glossaryapp/application/service/login_session_service.dart';
import 'package:injectable/injectable.dart';
import 'package:glossaryapp/infrastructure/result/login_result.dart';
import 'package:glossaryapp/application/repository/login_session_repository.dart';
import 'package:glossaryapp/application/repository/user_repository.dart';
import 'package:glossaryapp/infrastructure/authontication/cognito_auth_service.dart';

abstract class LoginService {
  Future<LoginResult> login(String email, String password);
}

@RegisterAs(LoginService)
@injectable
class LoginServiceImpl extends LoginService {
  UserRepository userRepo;
  CognitoAuthService _authService;
  LoginSessionService _sessionService;
  LoginServiceImpl(this.userRepo, this._authService, this._sessionService);

  Future<LoginResult> login(String email, String password) async {
    var result = await _authService.login(email, password);

    var cognitoSession = result.getSession();
    var user = userRepo.getByEmail(email);
    _sessionService.start(user, cognitoSession);

    return result;
  }
}
