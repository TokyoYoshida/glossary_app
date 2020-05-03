import 'package:glossaryapp/domain/core/model/word.dart';
import 'package:glossaryapp/domain/core/model/words.dart';
import 'package:injectable/injectable.dart';

class WordRepository {
  Map<String, Word> _words;

  Word find(String id) {
    return _words[id];
  }

  Words getAll() {
    List<Word> result = _words.entries.map((e) => e.value).toList();

    return Words(result);
  }

  void store(Word word) {
    _words[word.getId()] = word;
  }
}
