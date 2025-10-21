import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rika_morti_mobile/core/local_source/local_data_source.dart';
import 'package:rika_morti_mobile/core/network/network_info.dart';
import 'package:rika_morti_mobile/core/streams/favorite_stream_manager.dart';
import 'package:rika_morti_mobile/features/favorites/presentation/bloc/favorites_bloc.dart';
import 'package:rika_morti_mobile/features/home/data/datasources/local/home_local_data_source_impl.dart';
import 'package:rika_morti_mobile/features/home/data/datasources/remote/home_remote_datasource_impl.dart';
import 'package:rika_morti_mobile/features/home/data/repositories/home_repository_impl.dart';
import 'package:rika_morti_mobile/features/home/domain/repositories/home_respository.dart';
import 'package:rika_morti_mobile/features/home/domain/usecases/get_characters_use_case.dart';
import 'package:rika_morti_mobile/features/home/presentation/bloc/home_bloc.dart';
import 'package:rika_morti_mobile/features/main/presentation/bloc/main_bloc.dart';

final sl = GetIt.instance;
late Box<dynamic> _box;

Future<void> initInjection() async {
  /// Data Sources
  await initHive();

  /// initOthers
  initOthers();

  /// Streams
  initStreams();

  /// State Managements
  initStateManagements();

  /// Local Data Sources
  initLocalDataSources();

  /// Remote Data Sources
  initRemoteDataSource();

  /// UseCases
  initUseCases();

  /// Repositories
  initRepositories();
}

void initOthers() {
  sl.registerLazySingleton(() => InternetConnectionChecker.instance);
  sl.registerLazySingleton<NetworkInfoImpl>(() => NetworkInfoImpl(sl()));
  sl.registerLazySingleton(
    () => Dio()
      ..options = BaseOptions(
        contentType: 'application/json',
        sendTimeout: const Duration(seconds: 3),
        receiveTimeout: const Duration(seconds: 30),
        connectTimeout: const Duration(seconds: 30),
      )
      ..interceptors.addAll([
        LogInterceptor(
          error: kDebugMode,
          request: kDebugMode,
          requestBody: kDebugMode,
          responseBody: kDebugMode,
        ),
      ]),
  );
}

void initStateManagements() {
  /// main
  sl.registerFactory<MainBloc>(() => MainBloc());

  /// home
  sl.registerFactory<HomeBloc>(
    () => HomeBloc(
      getCharactersUseCase: sl<GetCharactersUseCase>(),
      localDataSource: sl<LocalDataSource>(),
      favoriteStreamManager: sl<FavoriteStreamManager>(),
    ),
  );

  /// Favorites
  sl.registerFactory<FavoritesBloc>(
    () => FavoritesBloc(
      localDataSource: sl<LocalDataSource>(),
      favoriteStreamManager: sl<FavoriteStreamManager>(),
    ),
  );
}

void initUseCases() {
  sl.registerFactory<GetCharactersUseCase>(
    () => GetCharactersUseCase(homeRepository: sl<HomeRepository>()),
  );
}

void initRepositories() {
  sl.registerSingleton<HomeRepository>(
    HomeRepositoryImpl(
      networkInfo: sl<NetworkInfoImpl>(),
      homeRemoteDataSource: sl<HomeRemoteDataSourceImpl>(),
      homeLocalDataSource: sl<HomeLocalDataSourceImpl>(),
    ),
  );
}

void initRemoteDataSource() {
  sl.registerSingleton<HomeRemoteDataSourceImpl>(
    HomeRemoteDataSourceImpl(
      dio: sl<Dio>(),
      localDataSource: sl<LocalDataSource>(),
    ),
  );
}

void initLocalDataSources() {
  sl.registerSingleton<LocalDataSource>(LocalDataSource(box: _box));
  sl.registerSingleton<HomeLocalDataSourceImpl>(
    HomeLocalDataSourceImpl(localDataSource: sl<LocalDataSource>()),
  );
}

Future<void> initHive() async {
  const boxName = 'rika_morti_box';
  Directory directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  _box = await Hive.openBox<dynamic>(boxName);
}

void initStreams() {
  sl.registerSingleton<FavoriteStreamManager>(FavoriteStreamManager());
}
