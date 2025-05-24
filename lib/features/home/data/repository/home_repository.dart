import 'package:al_omda/core/api/api_constances.dart';
import 'package:al_omda/core/api/api_methods.dart';
import 'package:al_omda/core/error/exception.dart';
import 'package:al_omda/features/home/data/models/categories_model.dart';
import 'package:al_omda/features/home/data/models/categories_products_model.dart';
import 'package:al_omda/features/home/data/models/home_sliders_model.dart';
import 'package:al_omda/features/home/data/models/products_top_rated_model.dart';
import 'package:al_omda/features/home/domain/repository/base_home_repository.dart';

import 'package:dartz/dartz.dart';

class HomeRepository implements BaseHomeRepository {
  final ApiMethods api;
  HomeRepository(this.api);
  @override
  Future<Either<String, List<HomeCategoriesModel>>> getHomeCategories() async {
    try {
      final response = await api.get(ApiConstances.categoriesPath);

      if (response is Map<String, dynamic>) {
        final data = response['data'] as List?;
        if (data != null && data.isNotEmpty) {
          final List<HomeCategoriesModel> categories =
              data
                  .map(
                    (item) => HomeCategoriesModel.fromJson(
                      item as Map<String, dynamic>,
                    ),
                  )
                  .toList();

          return Right(categories);
        } else {
          return Left('No categories found in the response.');
        }
      } else {
        return Left('Unexpected response format');
      }
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    } catch (e) {
      print('An unexpected error occurred: $e');
      return Left('An unexpected error occurred: $e');
    }
  }
  // Future<Either<String, List<HomeCategoriesModel>>> getHomeCategories() async {
  //   try {
  //     final response = await api.get(ApiConstances.categoriesPath);

  //     final List<HomeCategoriesModel> categories =
  //         List<HomeCategoriesModel>.from(
  //           (response["data"] as List).map(
  //             (e) => HomeCategoriesModel.fromJson(e),
  //           ),
  //         );
  //     return Right(categories);
  //   } on ServerException catch (e) {
  //     return left(e.errorModel.errorMessage);
  //   }
  // }

  @override
  Future<Either<String, List<HomeSlidersModel>>> getHomeSliders() async {
    try {
      final response = await api.get(ApiConstances.homeSliderPath);

      if (response is Map<String, dynamic> && response.containsKey('data')) {
        final List<dynamic> dataList = response['data'] as List;

        final List<HomeSlidersModel> homeSliders =
            dataList
                .map(
                  (e) => HomeSlidersModel.fromJson(e as Map<String, dynamic>),
                )
                .toList();

        return Right(homeSliders);
      } else if (response is List) {
        final List<HomeSlidersModel> homeSliders =
            response
                .map(
                  (e) => HomeSlidersModel.fromJson(e as Map<String, dynamic>),
                )
                .toList();

        return Right(homeSliders);
      } else {
        return Left("Invalid response format");
      }
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    }
  }
  // Future<Either<String, List<HomeSlidersModel>>> getHomeSliders() async {
  //   try {
  //     final response = await api.get(ApiConstances.homeSliderPath);
  //     print(response);
  //     final List<HomeSlidersModel> homeSliders = List<HomeSlidersModel>.from(
  //       (response.data["data"] as List).map((e) => CategoriesModel.fromJson(e)),
  //     );
  //     return Right(homeSliders);
  //   } on ServerException catch (e) {
  //     return left(e.errorModel.errorMessage);
  //   }
  // }

  @override
  // Future<Either<String, List<ProductsTopRatedModel>>>
  // getProductsTopRated() async {
  //   try {
  //     final response = await api.get(ApiConstances.productsTopRatedPath);
  //     if (response is Map<String, dynamic> && response.containsKey('data')) {
  //       final List<dynamic> dataList = response['data'] as List;
  //       final List<ProductsTopRatedModel> productsTopRated =
  //           dataList
  //               .map(
  //                 (e) =>
  //                     ProductsTopRatedModel.fromJson(e as Map<String, dynamic>),
  //               )
  //               .toList();
  //       return Right(productsTopRated);
  //     } else if (response is List) {
  //       final List<ProductsTopRatedModel> productsTopRated =
  //           response
  //               .map(
  //                 (e) =>
  //                     ProductsTopRatedModel.fromJson(e as Map<String, dynamic>),
  //               )
  //               .toList();
  //       return Right(productsTopRated);
  //     } else {
  //       return Left("Invalid response format");
  //     }
  //   } on ServerException catch (e) {
  //     return left(e.errorModel.errorMessage);
  //   }
  // }
  Future<Either<String, List<ProductsTopRatedModel>>>
  getProductsTopRated() async {
    try {
      final response = await api.get(ApiConstances.productsTopRatedPath);

      if (response is Map<String, dynamic>) {
        if (response.containsKey('data')) {
          final data = response['data']['data'];

          if (data is List) {
            // ✅ إذا كان data قائمة
            final List<ProductsTopRatedModel> productsTopRated =
                data
                    .map(
                      (e) => ProductsTopRatedModel.fromJson(
                        e as Map<String, dynamic>,
                      ),
                    )
                    .toList();

            return Right(productsTopRated);
          } else if (data is Map<String, dynamic>) {
            // ❗ إذا كان data كائن واحد فقط
            return Right([ProductsTopRatedModel.fromJson(data)]);
          }
        }

        return Left("Invalid response structure");
      } else if (response is List) {
        // ✅ إذا كان الرد مباشرة قائمة
        final List<ProductsTopRatedModel> productsTopRated =
            response
                .map(
                  (e) =>
                      ProductsTopRatedModel.fromJson(e as Map<String, dynamic>),
                )
                .toList();

        return Right(productsTopRated);
      } else {
        return Left("Unexpected response format");
      }
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    }
  }

  @override
  Future<Either<String, List<CategoriesProductsModel>>> getProductsByCategory(
    String categoryName,
  ) async {
    try {
      final String url =
          "${ApiConstances.productsByCategoryPath}category=$categoryName";
      final response = await api.get(url);

      if (response is Map<String, dynamic> && response.containsKey('data')) {
        final List<dynamic> dataList = response['data']['data'] as List;
        final List<CategoriesProductsModel> products =
            dataList
                .map(
                  (e) => CategoriesProductsModel.fromJson(
                    e as Map<String, dynamic>,
                  ),
                )
                .toList();
        return Right(products);
      } else if (response is List) {
        final List<CategoriesProductsModel> products =
            response
                .map(
                  (e) => CategoriesProductsModel.fromJson(
                    e as Map<String, dynamic>,
                  ),
                )
                .toList();
        return Right(products);
      } else {
        return Left("Invalid response format for category products");
      }
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    }
  }
}
