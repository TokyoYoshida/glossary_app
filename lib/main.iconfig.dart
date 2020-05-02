// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:glossaryapp/test.dart';
import 'package:glossaryapp/infrastructure/authontication/cognito_service.dart';
import 'package:glossaryapp/application/repository/login_session_repository.dart';
import 'package:glossaryapp/application/repository/user_repository.dart';
import 'package:glossaryapp/main.dart';
import 'package:glossaryapp/application/service/login_service.dart';
import 'package:glossaryapp/application/service/signup_service.dart';
import 'package:glossaryapp/view/login.dart';
import 'package:glossaryapp/view/verification_user.dart';
import 'package:get_it/get_it.dart';

void $initGetIt(GetIt g, {String environment}) {
  g.registerFactory<ServiceA>(() => ServiceA());
  g.registerFactory<ServiceB>(() => ServiceB(g<ServiceA>()));
  g.registerFactory<CognitoService>(() => CognitoService());
  g.registerFactory<UserRepository>(() => UserRepository());
  g.registerFactory<MyTop>(() => MyTop(g<ServiceB>()));
  g.registerFactory<LoginService>(
      () => LoginServiceImpl(g<UserRepository>(), g<LoginSessionRepository>()));
  g.registerFactory<SignupService>(() =>
      SignupServiceImpl(g<UserRepository>(), g<LoginSessionRepository>()));
  g.registerFactory<LoginScreen>(
      () => LoginScreen(g<SignupService>(), g<LoginService>()));
  g.registerFactory<VerificationUserScreen>(
      () => VerificationUserScreen(g<SignupService>()));
  g.registerFactory<VerificationUserScreenState>(
      () => VerificationUserScreenState(g<SignupService>()));
  g.registerFactory<MyApp>(() => MyApp(
        g<MyTop>(),
        g<LoginScreen>(),
        g<VerificationUserScreen>(),
      ));

  //Eager singletons must be registered in the right order
  g.registerSingleton<LoginSessionRepository>(LoginSessionRepository());
}
