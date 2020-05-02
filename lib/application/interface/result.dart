
abstract class AbstractResult {
  String getDescription();
  bool isSuccess();
  bool isFailure() {
    return !isSuccess();
  }
}

abstract class Result extends AbstractResult {
}
