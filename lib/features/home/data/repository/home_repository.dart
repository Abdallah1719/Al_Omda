import 'package:al_omda/core/api/api_constances.dart';
import 'package:al_omda/core/api/api_methods.dart';
import 'package:al_omda/core/error/exception.dart';
import 'package:al_omda/features/home/data/models/home_categories_model.dart';
import 'package:al_omda/features/home/data/models/home_slider_items_model.dart';
import 'package:al_omda/features/home/domain/repository/base_home_repository.dart';
import 'package:dartz/dartz.dart';

class HomeRepository implements BaseHomeRepository {
  final ApiMethods api;
  HomeRepository(this.api);
  @override
  Future<Either<String, List<HomeSliderItemsModel>>>
  getHomeSliderItems() async {
    try {
      final response = await api.get(ApiConstances.homeSliderPath);
      final List<dynamic> dataList = response['data'] as List;
      final List<HomeSliderItemsModel> homeSliders =
          dataList
              .map(
                (item) =>
                    HomeSliderItemsModel.fromJson(item as Map<String, dynamic>),
              )
              .toList();
      return Right(homeSliders);
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    }
  }

  @override
  Future<Either<String, List<HomeCategoriesModel>>> getHomeCategories() async {
    try {
      final response = await api.get(ApiConstances.categoriesPath);

      final dataList = response['data'] as List;
      final List<HomeCategoriesModel> categoriesList =
          dataList
              .map(
                (item) =>
                    HomeCategoriesModel.fromJson(item as Map<String, dynamic>),
              )
              .toList();
      return Right(categoriesList);
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    }
  }
}
