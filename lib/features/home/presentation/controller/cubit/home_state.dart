import 'package:al_omda/core/utils/enum.dart';
import 'package:al_omda/features/home/data/models/home_categories_model.dart';
import 'package:al_omda/features/home/data/models/home_sliders_model.dart';
import 'package:al_omda/features/products/data/models/products_model.dart';
import 'package:equatable/equatable.dart';

class HomeState extends Equatable {
  final List<HomeSlidersModel> homeSliders;
  final RequestState homeSlidersState;
  final String homeSlidersMessage;
  final List<HomeCategoriesModel> categories;
  final RequestState categoriesState;
  final String categoriesMessage;

  const HomeState({
    this.homeSliders = const [],
    this.homeSlidersState = RequestState.loading,
    this.homeSlidersMessage = '',

    this.categories = const [],
    this.categoriesState = RequestState.loading,
    this.categoriesMessage = '',
  });

  HomeState copyWith({
    List<HomeSlidersModel>? homeSliders,
    RequestState? homeSlidersState,
    String? homeSlidersMessage,
    List<HomeCategoriesModel>? categories,
    RequestState? categoriesState,
    String? categoriesMessage,
    List<ProductsModel>? productsTopRated,
    RequestState? productsTopRatedState,
    String? productsTopRatedMessage,
  }) {
    return HomeState(
      homeSliders: homeSliders ?? this.homeSliders,
      homeSlidersState: homeSlidersState ?? this.homeSlidersState,
      homeSlidersMessage: homeSlidersMessage ?? this.homeSlidersMessage,
      categories: categories ?? this.categories,
      categoriesState: categoriesState ?? this.categoriesState,
      categoriesMessage: categoriesMessage ?? this.categoriesMessage,
    );
  }

  @override
  List<Object?> get props => [
    homeSliders,
    homeSlidersState,
    homeSlidersMessage,
    categories,
    categoriesState,
    categoriesMessage,
  ];
}
