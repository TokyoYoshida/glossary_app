import 'package:glossaryapp/domain/generic_subdomain/model/user.dart';

abstract class LoginSessionGeneratable {
  LoginSession session;
  LoginSession getLoginSession();
}

abstract class LoginSession {
  User _loginUser;

  void setLoginUser(User loginUser) {
    _loginUser = loginUser;
  }

  User getLoginUser() {
    return _loginUser;
  }
}

