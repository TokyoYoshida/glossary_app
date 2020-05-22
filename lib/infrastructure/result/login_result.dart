import 'package:glossaryapp/infrastructure/result/result.dart';

abstract class LoginResult  extends AbstractResult {
  bool isNotConfirmedError();
}

