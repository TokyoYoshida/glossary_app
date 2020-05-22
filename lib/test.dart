import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

@injectable
class ServiceA {
  String test = "thisistest.";
}

@injectable
class ServiceB {
  ServiceA serviceA;
  ServiceB(ServiceA serviceA) {
    this.serviceA = serviceA;
  }

  String test() {
    return serviceA.test;
  }
}
