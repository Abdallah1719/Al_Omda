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
import 'package:al_omda/features/order/data/repository/order_repository.dart';
import 'package:al_omda/features/order/domain/repository/base_order_repository.dart';
import 'package:al_omda/features/order/presentation/controller/cubit/order_cubit.dart';
import 'package:al_omda/features/products/data/reposetory/products_repository.dart';
import 'package:al_omda/features/products/domain/repository/base_products_repository.dart';
import 'package:al_omda/features/products/presentation/controller/cubit/products_cubit.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

// void setupServiceLocator() {
//   //shared preferences
//   getIt.registerSingleton<CacheHelper>(CacheHelper());
//   // Dio
//   getIt.registerSingleton<Dio>(Dio());
//   //Api Methods
//   getIt.registerSingleton<ApiMethods>(DioMethods(getIt()));
//   //Auth
//   getIt.registerSingleton<BaseAuthRepository>(AuthRepository(getIt()));
//   getIt.registerFactory<AuthCubit>(() => AuthCubit(getIt()));
//   // Home
//   getIt.registerFactory<HomeCubit>(() => HomeCubit(getIt()));
//   getIt.registerSingleton<BaseHomeRepository>(HomeRepository(getIt()));
//   //Produsts
//   getIt.registerSingleton<BaseProductsRepository>(ProductsRepository(getIt()));
//   getIt.registerFactory<ProductsCubit>(() => ProductsCubit(getIt()));
//   //Account
//   getIt.registerSingleton<BaseAccountRepository>(AccountRepository(getIt()));
//   getIt.registerFactory<AccountCubit>(() => AccountCubit(getIt()));
//   //cart
//   getIt.registerSingleton<BaseCartRepository>(CartRepository(getIt()));
//   getIt.registerFactory<CartCubit>(() => CartCubit(getIt()));
//   // //order
//   // //  getIt.registerSingleton<BaseOrderRepository>(OrderRepository( getIt())
//   // // );
//   // // getIt.registerFactory<OrderCubit>(
//   // //   () => OrderCubit(orderRepository: getIt<OrderRepository>()),
//   // // );
//   // getIt.registerSingleton<BaseOrderRepository>(OrderRepository(getIt()));

//   // // Cubit - Factory registration للـ Cubit
//   // getIt.registerFactory<OrderCubit>(
//   //   () => OrderCubit(orderRepository: getIt<OrderRepository>()),
//   // );
//   //order

//   getIt.registerSingleton<BaseOrderRepository>(getIt<OrderRepository>());
//   getIt.registerFactory<OrderCubit>(
//     () => OrderCubit(), // ✅ صحيح
//   );
// }

void setupServiceLocator() {
  //shared preferences
  getIt.registerSingleton<CacheHelper>(CacheHelper());
  // Dio
  getIt.registerSingleton<Dio>(Dio());
  //Api Methods
  getIt.registerSingleton<ApiMethods>(DioMethods(getIt()));

  //Auth
  final authRepo = AuthRepository(getIt());
  getIt.registerSingleton<AuthRepository>(authRepo);
  getIt.registerSingleton<BaseAuthRepository>(authRepo);
  getIt.registerFactory<AuthCubit>(() => AuthCubit(getIt()));

  // Home
  final homeRepo = HomeRepository(getIt());
  getIt.registerSingleton<HomeRepository>(homeRepo);
  getIt.registerSingleton<BaseHomeRepository>(homeRepo);
  getIt.registerFactory<HomeCubit>(() => HomeCubit(getIt()));

  //Products
  final productsRepo = ProductsRepository(getIt());
  getIt.registerSingleton<ProductsRepository>(productsRepo);
  getIt.registerSingleton<BaseProductsRepository>(productsRepo);
  getIt.registerFactory<ProductsCubit>(() => ProductsCubit(getIt()));

  //Account
  final accountRepo = AccountRepository(getIt());
  getIt.registerSingleton<AccountRepository>(accountRepo); // ✅ أضف هذا
  getIt.registerSingleton<BaseAccountRepository>(accountRepo);
  getIt.registerFactory<AccountCubit>(() => AccountCubit(getIt()));

  //cart
  final cartRepo = CartRepository(getIt());
  getIt.registerSingleton<CartRepository>(cartRepo);
  getIt.registerSingleton<BaseCartRepository>(cartRepo);
  getIt.registerFactory<CartCubit>(() => CartCubit(getIt()));

  //order
  final orderRepo = OrderRepository(getIt());
  getIt.registerSingleton<OrderRepository>(orderRepo);
  getIt.registerSingleton<BaseOrderRepository>(orderRepo);

  getIt.registerFactory<OrderCubit>(() => OrderCubit(orderRepository: getIt()));
}
