import 'package:al_omda/features/home/data/models/home_categories_model.dart';
import 'package:al_omda/features/home/data/models/home_sliders_model.dart';
import 'package:dartz/dartz.dart';

abstract class BaseHomeRepository {
  Future<Either<String, List<HomeSlidersModel>>> getHomeSliders();
  Future<Either<String, List<HomeCategoriesModel>>> getHomeCategories();
}
