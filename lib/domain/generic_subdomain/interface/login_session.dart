import 'package:glossaryapp/domain/generic_subdomain/model/user.dart';
import 'package:glossaryapp/infrastructure/authontication/cognito_service.dart';

class LoginSession {
  User _loginUser;
  CognitoSession _congnitoSession;

  LoginSession(this._loginUser, this._congnitoSession);

  User getLoginUser() {
    return _loginUser;
  }
}

