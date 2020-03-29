// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:glossaryapp/test.dart';
import 'package:glossaryapp/main.dart';
import 'package:get_it/get_it.dart';

void $initGetIt(GetIt g, {String environment}) {
  g.registerFactory<ServiceA>(() => ServiceA());
  g.registerFactory<ServiceB>(() => ServiceB(g<ServiceA>()));
  g.registerFactory<MyTop>(() => MyTop(g<ServiceB>()));
  g.registerFactory<MyApp>(() => MyApp(g<MyTop>()));
}
