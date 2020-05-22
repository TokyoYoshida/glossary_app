import 'package:glossaryapp/domain/generic_subdomain/model/user.dart';
import 'package:glossaryapp/infrastructure/authontication/cognito_auth_service.dart';
import 'package:glossaryapp/infrastructure/session/api_session.dart';

class LoginSession {
  User _loginUser;
  CognitoApiSessionSupplier _cognitoSessionSupplier;

  LoginSession(this._loginUser, this._cognitoSessionSupplier);

  User getLoginUser() {
    return _loginUser;
  }

  ApiSessionSupplier getApiSessionSupplier() {
    return _cognitoSessionSupplier;
  }
}

