import 'package:glossaryapp/domain/core/model/word.dart';

class Words {
  List<Word> _words;

  Words(this._words);

  List<Word> getAll() {
    return _words;
  }
}
