import 'dart:async';
import 'package:glossaryapp/application/service/login_session_service.dart';
import 'package:injectable/injectable.dart';
import 'package:glossaryapp/infrastructure/result/signup_result.dart';
import 'package:glossaryapp/application/repository/login_session_repository.dart';
import 'package:glossaryapp/application/repository/user_repository.dart';
import 'package:glossaryapp/infrastructure/authontication/cognito_auth_service.dart';

abstract class SignupService {
  Future<SignupResult> signup(String email, String password);
  Future<VerificationUserResult> verificationUser(String code);
  Future<bool> resendVerificationCode();
}

@RegisterAs(SignupService)
@injectable
class SignupServiceImpl extends SignupService {
  UserRepository userRepo;
  CognitoAuthService _authService;
  LoginSessionService _sessionService;
  SignupServiceImpl(this.userRepo, this._authService, this._sessionService);

  Future<SignupResult> signup(String email, String password) async {
    var result = await _authService.signup(email, email, password);

    var cognitoSession = result.getSession();
    var user = userRepo.create(email);
    _sessionService.start(user, cognitoSession);

    return result;
  }

  Future<VerificationUserResult> verificationUser(String code) async {
    assert(_sessionService.isAlive());

    var user = _sessionService.getLoginUser();

    return await _authService.verificationUser(user.getEmail(), code);
  }

  Future<bool> resendVerificationCode() async {
    assert(_sessionService.isAlive());

    var user = _sessionService.getLoginUser();

    return await _authService.resendVerificationCode(user.getEmail());
  }
}