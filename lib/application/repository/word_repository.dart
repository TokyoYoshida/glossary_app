import 'package:glossaryapp/application/service/login_session_service.dart';
import 'package:glossaryapp/domain/core/model/word.dart';
import 'package:glossaryapp/domain/core/model/words.dart';
import 'package:glossaryapp/infrastructure/data_source/cognito_word_datasource_service.dart';
import 'package:glossaryapp/infrastructure/session/api_session.dart';
import 'package:injectable/injectable.dart';

@injectable
class WordRepository {
  CognitoWordDataSourceService _dataSourceService;
  LoginSessionService _sessionService;

  WordRepository(this._dataSourceService, this._sessionService);

  Map<String, Word> _words;

  Word find(String id) {
    return _words[id];
  }

  Future<Words> getAll() async {
    ApiSessionSupplier supplier = _sessionService.getApiSessionSupplier();

    List<Word> result = await _dataSourceService.getAll(supplier);

    return Words(result);
  }

  void store(Word word) {
    _words[word.getId()] = word;
  }
}
