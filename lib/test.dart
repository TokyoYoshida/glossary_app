import 'package:inject/inject.dart';

@provide
@singleton
class Employee {
  Name name;
  Employee(this.name);

  String test() {
    return name.nameValue;
  }
}

@provide
@singleton
class Name {
  String nameValue = "thisisTest";
}