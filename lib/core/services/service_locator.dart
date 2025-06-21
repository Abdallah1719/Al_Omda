import 'package:al_omda/core/api/api_methods.dart';
import 'package:al_omda/core/api/dio_methods.dart';
import 'package:al_omda/core/local_data_source/cache_helper.dart';
import 'package:al_omda/features/account/data/repository/account_repository.dart';
import 'package:al_omda/features/account/domain/repository/base_account_repository.dart';
import 'package:al_omda/features/account/presentation/controller/cubit/account_cubit.dart';
import 'package:al_omda/features/auth/data/repository/auth_repository.dart';
import 'package:al_omda/features/auth/domain/repository/base_auth_repository.dart';
import 'package:al_omda/features/auth/presentation/controller/cubit/auth_cubit.dart';
import 'package:al_omda/features/cart/data/repository/cart_repository.dart';
import 'package:al_omda/features/cart/domain/repository/base_cart_repository.dart';
import 'package:al_omda/features/cart/presentation/controller/cubit/cart_cubit.dart';
import 'package:al_omda/features/home/data/repository/home_repository.dart';
import 'package:al_omda/features/home/domain/repository/base_home_repository.dart';
import 'package:al_omda/features/home/presentation/controller/cubit/home_cubit.dart';
import 'package:al_omda/features/products/data/reposetory/products_repository.dart';
import 'package:al_omda/features/products/domain/repository/base_products_repository.dart';
import 'package:al_omda/features/products/presentation/controller/cubit/products_cubit.dart';
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
  //Auth
  getIt.registerSingleton<BaseAuthRepository>(AuthRepository(getIt()));
  getIt.registerFactory<AuthCubit>(() => AuthCubit(getIt()));
  // Home
  getIt.registerFactory<HomeCubit>(() => HomeCubit(getIt()));
  getIt.registerSingleton<BaseHomeRepository>(HomeRepository(getIt()));
  //Produsts
  getIt.registerSingleton<BaseProductsRepository>(ProductsRepository(getIt()));
  getIt.registerFactory<ProductsCubit>(() => ProductsCubit(getIt()));
  //Account
  getIt.registerSingleton<BaseAccountRepository>(AccountRepository(getIt()));
  getIt.registerFactory<AccountCubit>(() => AccountCubit(getIt()));
  //cart
  getIt.registerSingleton<BaseCartRepository>(CartRepository(getIt()));
  getIt.registerFactory<CartCubit>(() => CartCubit(getIt()));
}
