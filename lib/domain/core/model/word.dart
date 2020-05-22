import 'package:glossaryapp/domain/generic_subdomain/model/user.dart';

class Word {
  String _id;
  String _theWord;
  String _pronunciation;
  String _meaning;
  User _updateUser;
  DateTime _updateTime;

  Word(this._id, this._theWord, this._pronunciation, this._meaning, this._updateUser, this._updateTime);

  String getId() {
    return _id;
  }

  String getTheWord() {
    return _theWord;
  }

  String getPronunciation() {
    return _pronunciation;
  }

  String getMeaning() {
    return _meaning;
  }

  User getUpdateUser() {
    return _updateUser;
  }

  DateTime getUpdateTime() {
    return _updateTime;
  }
}
