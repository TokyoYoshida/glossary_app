import 'dart:async';
import 'package:injectable/injectable.dart';
import 'package:glossaryapp/domain/generic_subdomain/model/user.dart';
import 'package:glossaryapp/infrastructure/result/signup_result.dart';
import 'package:glossaryapp/application/repository/login_session_repository.dart';
import 'package:glossaryapp/application/repository/user_repository.dart';
import 'package:glossaryapp/infrastructure/authontication/cognito_service.dart';

abstract class SignupService {
  Future<SignupResult> signup(String email, String password);
  Future<VerificationUserResult> verificationUser(String code);
  Future<bool> resendVerificationCode();
}

@RegisterAs(SignupService)
@injectable
class SignupServiceImpl extends SignupService {
  UserRepository userRepo;
  LoginSessionRepository sessionRepo;
  SignupServiceImpl(this.userRepo, this.sessionRepo);

  Future<SignupResult> signup(String email, String password) async {
    var result = await CognitoService.signup(email, email, password);

    var session = result.getLoginSession();
    var user = userRepo.create(email);
    session.setLoginUser(user);
    sessionRepo.store(session);

    return result;
  }

  Future<VerificationUserResult> verificationUser(String code) async {
    var session = sessionRepo.get();
    var user = session.getLoginUser();
    return await CognitoService.verificationUser(user.getEmail(), code);
  }

  Future<bool> resendVerificationCode() async {
    var session = sessionRepo.get();
    var user = session.getLoginUser();
    return await CognitoService.resendVerificationCode(user.getEmail());
  }
}