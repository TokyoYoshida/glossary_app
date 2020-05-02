class ErrorMessageService {
  static String extractFromError(String original) {
    final exp = RegExp(r'message: ([^}]*)');
    var list =
    exp?.allMatches(original).map((match) => match.group(1)).toList();
    if (list.length == 1) {
      return list[0];
    }
    return "unknown error";
  }
}