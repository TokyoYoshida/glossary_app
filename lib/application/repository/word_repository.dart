import 'package:glossaryapp/domain/core/model/word.dart';
import 'package:glossaryapp/domain/core/model/words.dart';
import 'package:glossaryapp/infrastructure/data_source/cognito_word_datasource_service.dart';
import 'package:injectable/injectable.dart';

@injectable
class WordRepository {
  CognitoWordDataSourceService _dataSourceService;

  WordRepository(this._dataSourceService);

  Map<String, Word> _words;

  Word find(String id) {
    return _words[id];
  }

  Words getAll() {
    List<Word> result = _dataSourceService.getAll();

    return Words(result);
  }

  void store(Word word) {
    _words[word.getId()] = word;
  }
}
