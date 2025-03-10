import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

import 'package:hypothetical_app/core/cache/cache_consumer.dart';
import 'package:hypothetical_app/core/cache/cache_consumer_impl.dart';
import 'package:hypothetical_app/core/features/theme/data/datasources/theme_local_datasource.dart';
import 'package:hypothetical_app/core/features/theme/data/repositories/theme_repository_impl.dart';
import 'package:hypothetical_app/core/features/theme/domain/repositories/theme_repository.dart';
import 'package:hypothetical_app/core/features/theme/domain/usecases/change_theme.dart';
import 'package:hypothetical_app/core/features/theme/domain/usecases/get_saved_theme.dart';
import 'package:hypothetical_app/core/network/network_info.dart';
import 'package:hypothetical_app/features/auth/data/datasources/auth_datasources.dart';
import 'package:hypothetical_app/features/auth/data/repositories/auth_repositories_impl.dart';
import 'package:hypothetical_app/features/auth/domain/repositories/auth_repositories.dart';
import 'package:hypothetical_app/features/auth/domain/usecases/create_account_firestore_usecase.dart';
import 'package:hypothetical_app/features/auth/domain/usecases/create_account_usecase.dart';
import 'package:hypothetical_app/features/auth/domain/usecases/login_usecase.dart';
import 'package:hypothetical_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

final diInstance = GetIt.instance;

Future<void> initAppModule() async {
  //! Features
  initThemeModule();
  initAuthModule();

  //! Core
  diInstance.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(connectionChecker: diInstance()));

  diInstance.registerLazySingleton<CacheConsumer>(
      () => CacheConsumerImpl(sharedPreferences: diInstance()));
  //!External
  final sharedPreferences = await SharedPreferences.getInstance();
  diInstance.registerLazySingleton(() => sharedPreferences);
  diInstance.registerLazySingleton(() => Dio());

  diInstance.registerLazySingleton(() => LogInterceptor(
        request: true,
        requestBody: true,
        requestHeader: true,
        responseBody: true,
        responseHeader: true,
        error: true,
      ));
  // diInstance.registerLazySingleton(() => InternetConnectionChecker());
}

Future<void> initThemeModule() async {
  //?Use cases
  diInstance.registerLazySingleton<GetSavedThemeUseCase>(
      () => GetSavedThemeUseCase(themeRepository: diInstance()));
  diInstance.registerLazySingleton<ChangeThemeUseCase>(
      () => ChangeThemeUseCase(themeRepository: diInstance()));

  //?Repositories
  diInstance.registerLazySingleton<ThemeRepository>(
      () => ThemeRepositoryImpl(themeLocalDataSource: diInstance()));

  //?Data Sources
  diInstance.registerLazySingleton<ThemeLocalDataSource>(
      () => ThemeLocalDataSourceImpl(cacheConsumer: diInstance()));
}

Future<void> initAuthModule() async {
  diInstance.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  //Bloc
  diInstance.registerLazySingleton<AuthBloc>(
      () => AuthBloc(diInstance(), diInstance(), diInstance()));

  //DataSource
  diInstance.registerLazySingleton<AuthDatasources>(() => AuthDatasourcesImpl(
        firebaseAuth: diInstance(),
      ));

  //Repository
  diInstance.registerLazySingleton<AuthRepositories>(
      () => AuthRepositoriesImpl(authDatasources: diInstance()));

  //Use Cases
  diInstance.registerLazySingleton(() => LoginUseCase(diInstance()));
  diInstance.registerLazySingleton(() => CreateAccountUseCase(diInstance()));
  diInstance
      .registerLazySingleton(() => CreateAccountFirestoreUseCase(diInstance()));
}
