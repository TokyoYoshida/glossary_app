import 'package:glossaryapp/domain/generic_subdomain/model/user.dart';

class Word {
  String _id;
  String _theWord;
  String _meaning;
  User _updateUser;

  Word(this._id, this._theWord);

  String getId() {
    return _id;
  }
}
