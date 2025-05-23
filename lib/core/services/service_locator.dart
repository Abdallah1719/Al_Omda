import 'package:al_omda/core/api/api_methods.dart';
import 'package:al_omda/core/api/dio_methods.dart';
import 'package:al_omda/core/local_data_source/cache_helper.dart';
import 'package:al_omda/features/auth/data/repository/auth_repository.dart';
import 'package:al_omda/features/auth/domain/repository/base_auth_repository.dart';
import 'package:al_omda/features/auth/presentation/controller/cubit/auth_cubit.dart';
import 'package:al_omda/features/home/data/repository/home_repository.dart';
import 'package:al_omda/features/home/domain/repository/base_home_repository.dart';
import 'package:al_omda/features/home/presentation/controller/cubit/home_cubit.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  //shared preferences
  getIt.registerSingleton<CacheHelper>(CacheHelper());
  // Dio
  getIt.registerSingleton<Dio>(Dio());
  //Api Methods
  getIt.registerSingleton<ApiMethods>(DioMethods(getIt()));
  // Base Auth Repository
  getIt.registerSingleton<BaseAuthRepository>(AuthRepository(getIt()));
  // Auth Cubit
  getIt.registerFactory<AuthCubit>(() => AuthCubit(getIt()));
  // Base Home Repository
  getIt.registerSingleton<BaseHomeRepository>(HomeRepository(getIt()));
  // Home Cubit
  getIt.registerFactory<HomeCubit>(() => HomeCubit(getIt()));
}
