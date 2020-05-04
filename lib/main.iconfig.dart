// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:glossaryapp/test.dart';
import 'package:glossaryapp/application/repository/login_session_repository.dart';
import 'package:glossaryapp/application/repository/user_repository.dart';
import 'package:glossaryapp/application/repository/word_repository.dart';
import 'package:glossaryapp/application/service/glossary_service.dart';
import 'package:glossaryapp/application/service/login_session_service.dart';
import 'package:glossaryapp/presentation/word_list.dart';
import 'package:glossaryapp/presentation/word_detail.dart';
import 'package:glossaryapp/infrastructure/authontication/cognito_auth_service.dart';
import 'package:glossaryapp/infrastructure/data_source/cognito_graphql_service.dart';
import 'package:glossaryapp/main.dart';
import 'package:glossaryapp/application/service/login_service.dart';
import 'package:glossaryapp/application/service/signup_service.dart';
import 'package:glossaryapp/presentation/login.dart';
import 'package:glossaryapp/presentation/verification_user.dart';
import 'package:get_it/get_it.dart';

void $initGetIt(GetIt g, {String environment}) {
  g.registerFactory<ServiceA>(() => ServiceA());
  g.registerFactory<ServiceB>(() => ServiceB(g<ServiceA>()));
  g.registerFactory<UserRepository>(() => UserRepository());
  g.registerFactory<WordRepository>(() => WordRepository());
  g.registerFactory<GlossaryService>(
      () => GlossaryService(g<WordRepository>()));
  g.registerFactory<LoginSessionService>(
      () => LoginSessionService(g<LoginSessionRepository>()));
  g.registerFactory<WordListViewModel>(() => WordListViewModel());
  g.registerFactory<WordListScreen>(() => WordListScreen());
  g.registerFactory<WordDetailViewModel>(() => WordDetailViewModel());
  g.registerFactory<WordDetailScreen>(() => WordDetailScreen());
  g.registerFactory<CognitoGraphQLService>(() => CognitoGraphQLService());
  g.registerFactory<MyTop>(() => MyTop(g<ServiceB>()));
  g.registerFactory<LoginService>(() => LoginServiceImpl(
        g<UserRepository>(),
        g<CognitoAuthService>(),
        g<LoginSessionService>(),
      ));
  g.registerFactory<SignupService>(() => SignupServiceImpl(
        g<UserRepository>(),
        g<CognitoAuthService>(),
        g<LoginSessionService>(),
      ));
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
        g<WordListScreen>(),
        g<WordDetailScreen>(),
      ));

  //Eager singletons must be registered in the right order
  g.registerSingleton<LoginSessionRepository>(LoginSessionRepository());
  g.registerSingleton<CognitoAuthService>(CognitoAuthService());
}
