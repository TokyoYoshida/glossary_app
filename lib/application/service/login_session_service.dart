import 'package:glossaryapp/application/repository/login_session_repository.dart';
import 'package:glossaryapp/domain/generic_subdomain/model/user.dart';
import 'package:glossaryapp/infrastructure/authontication/cognito_service.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoginSessionService {
  LoginSessionRepository _repo;

  LoginSessionService(this._repo);

  void start(User loginUser, CognitoSession cognitoSession) {
      var loginSession = _repo.create(loginUser, cognitoSession);
      _repo.store(loginSession);
  }

  bool isAlive() {
    return _repo.get() != null;
  }

  User getLoginUser() {
    var session = _repo.get();
    return session.getLoginUser();
  }
}
