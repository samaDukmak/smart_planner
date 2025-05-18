// injector.dart
// import 'package:get_it/get_it.dart';
// import 'package:dio/dio.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// final getIt = GetIt.instance;

// Future<void> setupLocator() async {
//   // Shared prefs & app prefs
//   final prefs = await SharedPreferences.getInstance();
//   getIt.registerSingleton<SharedPreferences>(prefs);
//   getIt.registerLazySingleton(() => AppPreferences(prefs));

//   // Dio + interceptor
//   final dio = Dio(BaseOptions(baseUrl: 'https://api.example.com'));
//   dio.interceptors.add(AuthInterceptor(getIt<AppPreferences>()));
//   getIt.registerSingleton<Dio>(dio);

//   // Auth data source & repo
//   getIt.registerLazySingleton<AuthRemoteDataSource>(() => AuthRemoteDataSourceImpl(getIt<Dio>()));
//   getIt.registerLazySingleton(() => AuthRepositoryImpl(getIt<AuthRemoteDataSource>(), getIt<AppPreferences>()));
// }