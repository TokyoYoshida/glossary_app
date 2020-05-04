import 'package:amazon_cognito_identity_dart/cognito.dart';
import 'package:glossaryapp/infrastructure/authontication/cognito_auth_service.dart';
import 'package:injectable/injectable.dart';

abstract class CognitoApi {
  void setSession(CognitoUserSession session);
}

abstract class ApiSessionSupplier {
  void getSession(CognitoApi api);
}

class CognitoApiSessionSupplier implements ApiSessionSupplier {
  CognitoUserSession _session;

  CognitoApiSessionSupplier(this._session);

  void getSession(CognitoApi api) {
    api.setSession(_session);
  }
}