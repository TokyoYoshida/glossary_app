// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:glossaryapp/test.dart';
import 'package:glossaryapp/infrastructure/cognito_service.dart';
import 'package:glossaryapp/domain/login_user.dart';
import 'package:glossaryapp/main.dart';
import 'package:glossaryapp/application/signup_service.dart';
import 'package:glossaryapp/view/auth_view.dart';
import 'package:get_it/get_it.dart';

void $initGetIt(GetIt g, {String environment}) {
  g.registerFactory<ServiceA>(() => ServiceA());
  g.registerFactory<ServiceB>(() => ServiceB(g<ServiceA>()));
  g.registerFactory<CognitoService>(() => CognitoService());
  g.registerFactory<MyTop>(() => MyTop(g<ServiceB>()));
  g.registerFactory<SignupService>(() => SignupServiceImpl(g<LoginUser>()));
  g.registerFactory<LoginScreen>(() => LoginScreen(g<SignupService>()));
  g.registerFactory<LoginTopScreen>(() => LoginTopScreen(g<LoginScreen>()));
  g.registerFactory<MyApp>(() => MyApp(g<MyTop>(), g<LoginTopScreen>()));

  //Eager singletons must be registered in the right order
  g.registerSingleton<LoginUser>(LoginUserImpl());
}