import 'package:inject/inject.dart';
import 'package:glossaryapp/test.dart';
import '../main.dart';
import 'app_injector.inject.dart' as g;

@Injector()
abstract class AppInjector {
  @provide
  MyApp get app;

  @provide
  MyTop get mytop;

  @provide
  Employee get employee;

  @provide
  Name get name;

  static Future<AppInjector> create() {
    return g.AppInjector$Injector.create();
  }
}