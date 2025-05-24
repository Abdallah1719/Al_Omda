import 'package:al_omda/core/api/api_constances.dart';
import 'package:al_omda/core/api/api_methods.dart';
import 'package:al_omda/core/error/exception.dart';
import 'package:al_omda/features/categories/data/models/categories_model.dart';
import 'package:al_omda/features/categories/data/models/products_by_categories_model.dart';
import 'package:al_omda/features/categories/domain/repository/base_categories_repository.dart';
import 'package:dartz/dartz.dart';

class CategoriesRepository implements BaseCategoriesRepository {
  final ApiMethods api;
  CategoriesRepository(this.api);
  @override
  Future<Either<String, List<CategoriesModel>>> getCategories() async {
    try {
      final response = await api.get(ApiConstances.categoriesPath);

      if (response is Map<String, dynamic>) {
        final data = response['data'] as List?;
        if (data != null && data.isNotEmpty) {
          final List<CategoriesModel> categories =
              data
                  .map(
                    (item) =>
                        CategoriesModel.fromJson(item as Map<String, dynamic>),
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
      return Left('An unexpected error occurred: $e');
    }
  }

  @override
  Future<Either<String, List<ProductsByCategoriesModel>>>
  getProductsByCategories(String categoryName) async {
    try {
      final String url =
          "${ApiConstances.productsByCategoryPath}category=$categoryName";
      final response = await api.get(url);

      if (response is Map<String, dynamic> && response.containsKey('data')) {
        final List<dynamic> dataList = response['data']['data'] as List;
        final List<ProductsByCategoriesModel> products =
            dataList
                .map(
                  (e) => ProductsByCategoriesModel.fromJson(
                    e as Map<String, dynamic>,
                  ),
                )
                .toList();
        return Right(products);
      } else if (response is List) {
        final List<ProductsByCategoriesModel> products =
            response
                .map(
                  (e) => ProductsByCategoriesModel.fromJson(
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
