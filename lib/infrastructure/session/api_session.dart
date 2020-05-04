import 'package:glossaryapp/infrastructure/authontication/cognito_auth_service.dart';
import 'package:injectable/injectable.dart';

abstract class CognitoApi {
  void setSession(CognitoSession session);
}

abstract class ApiSessionSupplier {
  void getSession(CognitoApi api);
}

class CognitoApiSessionSupplier implements ApiSessionSupplier {
  CognitoSession _session;

  CognitoApiSessionSupplier(this._session);

  void getSession(CognitoApi api) {
    api.setSession(_session);
  }
}