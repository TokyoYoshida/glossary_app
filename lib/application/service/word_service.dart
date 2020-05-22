import 'package:glossaryapp/application/repository/word_repository.dart';
import 'package:glossaryapp/domain/core/model/word.dart';
import 'package:glossaryapp/domain/core/model/words.dart';
import 'package:injectable/injectable.dart';

@injectable
class WordService {
  WordRepository _repo;

  WordService(this._repo);

  Future<Words> getAll() {
    return _repo.getAll();
  }
}