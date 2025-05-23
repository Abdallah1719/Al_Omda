import 'package:al_omda/features/home/data/models/categories_model.dart';
import 'package:al_omda/features/home/data/models/home_sliders_model.dart';
import 'package:al_omda/features/home/data/models/products_top_rated_model.dart';
import 'package:dartz/dartz.dart';

abstract class BaseHomeRepository {
  Future<Either<String, List<HomeSlidersModel>>> getHomeSliders();
  Future<Either<String, List<HomeCategoriesModel>>> getHomeCategories();
  Future<Either<String, List<ProductsTopRatedModel>>> getProductsTopRated();
  // Future<Either<Failure, List<CategoriesProducts>>> getCategoriesProducts();
}
