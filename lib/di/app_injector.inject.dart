import 'app_injector.dart' as _i1;
import '../test.dart' as _i2;
import 'dart:async' as _i3;
import '../main.dart' as _i4;

class AppInjector$Injector implements _i1.AppInjector {
  AppInjector$Injector._();

  _i2.Name _singletonName;

  _i2.Employee _singletonEmployee;

  static _i3.Future<_i1.AppInjector> create() async {
    final injector = AppInjector$Injector._();

    return injector;
  }

  _i4.MyApp _createMyApp() => _i4.MyApp(_createMyTop());
  _i4.MyTop _createMyTop() => _i4.MyTop(_createEmployee());
  _i2.Employee _createEmployee() =>
      _singletonEmployee ??= _i2.Employee(_createName());
  _i2.Name _createName() => _singletonName ??= _i2.Name();
  @override
  _i4.MyApp get app => _createMyApp();
  @override
  _i4.MyTop get mytop => _createMyTop();
  @override
  _i2.Employee get employee => _createEmployee();
  @override
  _i2.Name get name => _createName();
}
