import 'package:injectable/injectable.dart';
import 'package:glossaryapp/generic_subdomain/interface/login_session.dart';

@singleton
@injectable
class LoginSessionRepository {
  LoginSession _session;

  LoginSession get() {
    return _session;
  }

  void store(LoginSession session) {
    this._session = session;
  }
}
