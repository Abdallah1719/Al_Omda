import 'package:al_omda/core/utils/enum.dart';
import 'package:al_omda/features/home/data/models/home_sliders_model.dart';
import 'package:al_omda/features/home/data/models/products_top_rated_model.dart';
import 'package:equatable/equatable.dart';

class HomeState extends Equatable {
  final List<HomeSlidersModel> homeSliders;
  final RequestState homeSlidersState;
  final String homeSlidersMessage;
  // final List<HomeCategoriesModel> categories;
  // final RequestState categoriesState;
  // final String categoriesMessage;
  final List<ProductsTopRatedModel> productsTopRated;
  final RequestState productsTopRatedState;
  final String productsTopRatedMessage;
  // final RequestState productsByCategoryState;
  // final String productsByCategoryMessage;
  // final List<CategoriesProductsModel> productsByCategory;

  const HomeState({
    this.homeSliders = const [],
    this.homeSlidersState = RequestState.loading,
    this.homeSlidersMessage = '',

    // this.categories = const [],
    // this.categoriesState = RequestState.loading,
    // this.categoriesMessage = '',
    this.productsTopRated = const [],
    this.productsTopRatedState = RequestState.loading,
    this.productsTopRatedMessage = '',

    // this.productsByCategoryState = RequestState.initial,
    // this.productsByCategoryMessage = '',
    // this.productsByCategory = const [],
  });

  HomeState copyWith({
    List<HomeSlidersModel>? homeSliders,
    RequestState? homeSlidersState,
    String? homeSlidersMessage,
    // List<HomeCategoriesModel>? categories,
    // RequestState? categoriesState,
    // String? categoriesMessage,
    List<ProductsTopRatedModel>? productsTopRated,
    RequestState? productsTopRatedState,
    String? productsTopRatedMessage,
    // RequestState? productsByCategoryState,
    // String? productsByCategoryMessage,
    // List<CategoriesProductsModel>? productsByCategory,
  }) {
    return HomeState(
      homeSliders: homeSliders ?? this.homeSliders,
      homeSlidersState: homeSlidersState ?? this.homeSlidersState,
      homeSlidersMessage: homeSlidersMessage ?? this.homeSlidersMessage,
      // categories: categories ?? this.categories,
      // categoriesState: categoriesState ?? this.categoriesState,
      // categoriesMessage: categoriesMessage ?? this.categoriesMessage,
      productsTopRated: productsTopRated ?? this.productsTopRated,
      productsTopRatedState:
          productsTopRatedState ?? this.productsTopRatedState,
      productsTopRatedMessage:
          productsTopRatedMessage ?? this.productsTopRatedMessage,

      // productsByCategoryState:
      //     productsByCategoryState ?? this.productsByCategoryState,
      // productsByCategoryMessage:
      //     productsByCategoryMessage ?? this.productsByCategoryMessage,
      // productsByCategory: productsByCategory ?? this.productsByCategory,
    );
  }

  @override
  List<Object?> get props => [
    homeSliders,
    homeSlidersState,
    homeSlidersMessage,
    // categories,
    // categoriesState,
    // categoriesMessage,
    productsTopRated,
    productsTopRatedState,
    productsTopRatedMessage,
    // productsByCategoryState,
    // productsByCategoryMessage,
    // productsByCategory,
  ];
}
