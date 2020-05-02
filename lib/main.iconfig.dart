// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:glossaryapp/test.dart';
import 'package:glossaryapp/application/service/login_service.dart';
import 'package:glossaryapp/domain/model/user.dart';
import 'package:glossaryapp/application/service/signup_service.dart';
import 'package:glossaryapp/infrastructure/authontication/cognito_service.dart';
import 'package:glossaryapp/main.dart';
import 'package:glossaryapp/view/login.dart';
import 'package:glossaryapp/view/verification_user.dart';
import 'package:get_it/get_it.dart';

void $initGetIt(GetIt g, {String environment}) {
  g.registerFactory<ServiceA>(() => ServiceA());
  g.registerFactory<ServiceB>(() => ServiceB(g<ServiceA>()));
  g.registerFactory<LoginService>(() => LoginServiceImpl(g<User>()));
  g.registerFactory<SignupService>(() => SignupServiceImpl(g<User>()));
  g.registerFactory<CognitoService>(() => CognitoService());
  g.registerFactory<MyTop>(() => MyTop(g<ServiceB>()));
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
}
