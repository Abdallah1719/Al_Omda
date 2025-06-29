import 'package:al_omda/features/home/data/models/home_categories_model.dart';
import 'package:al_omda/features/home/data/models/home_slider_items_model.dart';
import 'package:dartz/dartz.dart';

abstract class BaseHomeRepository {
  Future<Either<String, List<HomeSliderItemsModel>>> getHomeSliderItems();
  Future<Either<String, List<HomeCategoriesModel>>> getHomeCategories();
}
