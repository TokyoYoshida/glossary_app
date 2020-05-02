import 'package:injectable/injectable.dart';

import 'package:glossaryapp/infrastructure/authontication/cognito_service.dart';

class User {
  String _email;

  User(this._email);

  String getEmail() {
    return _email;
  }

  Future<bool> isConfirmed() async {
    return await CognitoService.isConfirmed(this._email);
  }
}
