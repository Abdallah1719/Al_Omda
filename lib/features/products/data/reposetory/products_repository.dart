import 'package:al_omda/core/api/api_constances.dart';
import 'package:al_omda/core/api/api_methods.dart';
import 'package:al_omda/core/error/exception.dart';
import 'package:al_omda/features/products/data/models/products_model.dart';
import 'package:al_omda/features/products/data/models/products_by_categories_model.dart';
import 'package:al_omda/features/products/data/models/products_top_rated_model.dart';
import 'package:al_omda/features/products/domain/repository/base_products_repository.dart';
import 'package:dartz/dartz.dart';

class ProductsRepository implements BaseProductsRepository {
  final ApiMethods api;
  ProductsRepository(this.api);
  @override
  Future<Either<String, List<ProductsModel>>> getMostRecentProducts() async {
    try {
      final response = await api.get(ApiConstances.productsPath);
      if (response is Map<String, dynamic> && response.containsKey('data')) {
        final List<dynamic> dataList = response['data']['data'] as List;
        final List<ProductsModel> products =
            dataList
                .map((e) => ProductsModel.fromJson(e as Map<String, dynamic>))
                .toList();
        return Right(products);
      } else if (response is List) {
        final List<ProductsModel> products =
            response
                .map((e) => ProductsModel.fromJson(e as Map<String, dynamic>))
                .toList();
        return Right(products);
      } else {
        return Left("Invalid response format for most recent products");
      }
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    }
  }

  @override
  Future<Either<String, List<ProductsModel>>>
  getHomeProductsTopRated() async {
    try {
      final response = await api.get(ApiConstances.productsTopRatedPath);

      if (response is Map<String, dynamic>) {
        if (response.containsKey('data')) {
          final data = response['data']['data'];

          if (data is List) {
            final List<ProductsModel> productsTopRated =
                data
                    .map(
                      (e) => ProductsModel.fromJson(
                        e as Map<String, dynamic>,
                      ),
                    )
                    .toList();

            return Right(productsTopRated);
          } else if (data is Map<String, dynamic>) {
            return Right([ProductsModel.fromJson(data)]);
          }
        }

        return Left("Invalid response structure");
      } else if (response is List) {
        final List<ProductsModel> productsTopRated =
            response
                .map(
                  (e) =>
                      ProductsModel.fromJson(e as Map<String, dynamic>),
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
  Future<Either<String, List<ProductsModel>>>
  getProductsByCategories(String categoryName) async {
    try {
      final response = await api.get(
        ApiConstances.productsPath,
        queryParameters: {'category': categoryName},
      );

      if (response is Map<String, dynamic> && response.containsKey('data')) {
        final List<dynamic> dataList = response['data']['data'] as List;
        final List<ProductsModel> products =
            dataList
                .map(
                  (e) => ProductsModel.fromJson(
                    e as Map<String, dynamic>,
                  ),
                )
                .toList();
        return Right(products);
      } else if (response is List) {
        final List<ProductsModel> products =
            response
                .map(
                  (e) => ProductsModel.fromJson(
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
