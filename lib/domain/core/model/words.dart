import 'package:glossaryapp/domain/core/model/word.dart';

class Words {
  List<Word> _words;

  Words(this._words);

  int getCount() {
    return _words.length;
  }

  List<Word> getAll() {
    return List.unmodifiable(_words);
  }

  Word get(int index) {
    return _words[index];
  }
}
