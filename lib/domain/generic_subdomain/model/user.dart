import 'package:injectable/injectable.dart';

import 'package:glossaryapp/infrastructure/authontication/cognito_auth_service.dart';

class User {
  String _email;

  User(this._email);

  String getEmail() {
    return _email;
  }
}
