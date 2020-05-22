import 'package:glossaryapp/application/repository/word_repository.dart';
import 'package:glossaryapp/domain/core/model/words.dart';
import 'package:injectable/injectable.dart';

@injectable
class GlossaryService {
  WordRepository _wordRepo;

  GlossaryService(this._wordRepo);

  Future<Words> getAll() {
    return _wordRepo.getAll();
  }
}