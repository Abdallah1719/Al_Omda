import 'package:al_omda/core/api/api_constances.dart';
import 'package:al_omda/core/api/api_methods.dart';
import 'package:al_omda/core/error/exception.dart';
import 'package:al_omda/features/products/data/models/most_resent_products_model.dart';
import 'package:al_omda/features/products/domain/repository/base_products_repository.dart';
import 'package:dartz/dartz.dart';

class ProductsRepository implements BaseProductsRepository {
  final ApiMethods api;
  ProductsRepository(this.api);
  @override
  Future<Either<String, List<MostRecentProductsModel>>>
  getMostRecentProducts() async {
    try {
      final response = await api.get(ApiConstances.mostRecentProductsPath);
      if (response is Map<String, dynamic> && response.containsKey('data')) {
        final List<dynamic> dataList = response['data']['data'] as List;
        final List<MostRecentProductsModel> products =
            dataList
                .map(
                  (e) => MostRecentProductsModel.fromJson(
                    e as Map<String, dynamic>,
                  ),
                )
                .toList();
        return Right(products);
      } else if (response is List) {
        final List<MostRecentProductsModel> products =
            response
                .map(
                  (e) => MostRecentProductsModel.fromJson(
                    e as Map<String, dynamic>,
                  ),
                )
                .toList();
        return Right(products);
      } else {
        return Left("Invalid response format for most recent products");
      }
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    }
  }
}
