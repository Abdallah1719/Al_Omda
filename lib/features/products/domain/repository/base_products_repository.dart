import 'package:al_omda/features/products/data/models/products_model.dart';
import 'package:dartz/dartz.dart';

abstract class BaseProductsRepository {
  Future<Either<String, List<ProductsModel>>> getMostRecentProducts();
  Future<Either<String, List<ProductsModel>>> getHomeProductsTopRated();
  Future<Either<String, List<ProductsModel>>> getProductsByCategories(
    String categoryName,
  );
}
