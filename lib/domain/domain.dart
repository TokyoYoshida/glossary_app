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

abstract class Entity {
  String id;
}

class Word extends Entity {
  String theWord;
  String description;
  User updateUser;
}

class User extends Entity{
  String nickName;
}
