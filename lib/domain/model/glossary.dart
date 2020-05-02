import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

abstract class DomainModel {

}

class GlossaryRepository {
  find(String id) {
  }

  List loadAll() {
  }
}

class Word {
  String id;
  String theWord;
  String description;
  User updateUser;
}

class User {
  String id;
  String nickName;
}
