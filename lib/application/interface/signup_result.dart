import 'package:glossaryapp/application/interface/result.dart';

abstract class SignupResult extends AbstractResult {
  bool isUserNameExistsError();
}
