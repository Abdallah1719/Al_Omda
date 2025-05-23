import 'package:al_omda/core/api/api_constances.dart';
import 'package:al_omda/core/api/api_methods.dart';
import 'package:al_omda/core/error/exception.dart';
import 'package:al_omda/features/home/data/models/categories_model.dart';
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
  Future<Either<String, List<ProductsTopRatedModel>>>
  getProductsTopRated() async {
    try {
      final response = await api.get(ApiConstances.productsTopRatedPath);
      print("Response from repository: $response");

      final List<ProductsTopRatedModel> productsTopRated =
          List<ProductsTopRatedModel>.from(
            (response.data["data"] as List).map(
              (e) => ProductsTopRatedModel.fromJson(e),
            ),
          );
      return Right(productsTopRated);
    } on ServerException catch (e) {
      return left(e.errorModel.errorMessage);
    }
  }
}
