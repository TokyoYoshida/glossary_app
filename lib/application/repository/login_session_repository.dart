import 'package:glossaryapp/domain/generic_subdomain/model/user.dart';
import 'package:glossaryapp/infrastructure/authontication/cognito_service.dart';
import 'package:injectable/injectable.dart';
import 'package:glossaryapp/domain/generic_subdomain/interface/login_session.dart';

@singleton
@injectable
class LoginSessionRepository {
  LoginSession _session;

  LoginSession create(User loginUser, CognitoSession session) {
    return LoginSession(loginUser, session);
  }

  LoginSession get() {
    return _session;
  }

  void store(LoginSession session) {
    this._session = session;
  }
}
