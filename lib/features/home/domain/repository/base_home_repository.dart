import 'package:al_omda/features/home/data/models/home_sliders_model.dart';
import 'package:al_omda/features/home/data/models/products_top_rated_model.dart';
import 'package:dartz/dartz.dart';

abstract class BaseHomeRepository {
  Future<Either<String, List<HomeSlidersModel>>> getHomeSliders();
  // Future<Either<String, List<HomeCategoriesModel>>> getHomeCategories();
  Future<Either<String, List<ProductsTopRatedModel>>> getHomeProductsTopRated();
  // Future<Either<String, List<CategoriesProductsModel>>> getProductsByCategories(
  //   String categoryName,
  // );
}
