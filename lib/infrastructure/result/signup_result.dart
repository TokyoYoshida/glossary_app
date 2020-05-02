import 'package:glossaryapp/infrastructure/result/result.dart';

abstract class SignupResult extends AbstractResult {
  bool isUserNameExistsError();
}
