import 'package:glossaryapp/domain/generic_subdomain/model/user.dart';
import 'package:glossaryapp/infrastructure/authontication/cognito_auth_service.dart';
import 'package:glossaryapp/infrastructure/session/api_session.dart';
import 'package:injectable/injectable.dart';
import 'package:glossaryapp/domain/generic_subdomain/interface/login_session.dart';

@singleton
@injectable
class LoginSessionRepository {
  LoginSession _session;

  LoginSession create(User loginUser, ApiSessionSupplier supplier) {
    return LoginSession(loginUser, supplier);
  }

  LoginSession get() {
    return _session;
  }

  void store(LoginSession session) {
    this._session = session;
  }
}
