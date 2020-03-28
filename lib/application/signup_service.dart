import 'package:glossaryapp/domain/domain.dart';
import 'package:glossaryapp/domain/user.dart';

import '../infrastructure/cognito_service.dart';
import '../global/result.dart';

abstract class SignupService {
  Future<SignupResult> signup(String name, String email, String password);
}

class SignupServiceImpl extends SignupService {
  static final SignupServiceImpl _singleton = new SignupServiceImpl._internal();

  factory SignupServiceImpl() {
    return _singleton;
  }

  SignupServiceImpl._internal();

  Future<SignupResult> signup(String name, String email, String password) async {
    return
  }
}