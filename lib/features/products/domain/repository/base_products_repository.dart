import 'package:al_omda/features/products/data/models/most_resent_products_model.dart';
import 'package:al_omda/features/products/data/models/products_by_categories_model.dart';
import 'package:al_omda/features/products/data/models/products_top_rated_model.dart';
import 'package:dartz/dartz.dart';

abstract class BaseProductsRepository {
  Future<Either<String, List<MostRecentProductsModel>>> getMostRecentProducts();
  Future<Either<String, List<ProductsTopRatedModel>>> getHomeProductsTopRated();
  Future<Either<String, List<ProductsByCategoriesModel>>>
  getProductsByCategories(String categoryName);
}
