import 'package:al_omda/core/utils/enum.dart';
import 'package:al_omda/features/home/data/models/home_categories_model.dart';
import 'package:al_omda/features/home/data/models/home_slider_items_model.dart';
import 'package:equatable/equatable.dart';

class HomeState extends Equatable {
  final List<HomeSliderItemsModel> homeSliderItems;
  final RequestState homeSliderItemsState;
  final String homeSliderItemsMessage;
  final List<HomeCategoriesModel> categoriesList;
  final RequestState categoriesState;
  final String categoriesMessage;

  const HomeState({
    this.homeSliderItems = const [],
    this.homeSliderItemsState = RequestState.loading,
    this.homeSliderItemsMessage = '',
    this.categoriesList = const [],
    this.categoriesState = RequestState.loading,
    this.categoriesMessage = '',
  });

  HomeState copyWith({
    List<HomeSliderItemsModel>? homeSliderItems,
    RequestState? homeSliderItemsState,
    String? homeSliderItemsMessage,
    List<HomeCategoriesModel>? categoriesList,
    RequestState? categoriesState,
    String? categoriesMessage,
  }) {
    return HomeState(
      homeSliderItems: homeSliderItems ?? this.homeSliderItems,
      homeSliderItemsState: homeSliderItemsState ?? this.homeSliderItemsState,
      homeSliderItemsMessage:
          homeSliderItemsMessage ?? this.homeSliderItemsMessage,
      categoriesList: categoriesList ?? this.categoriesList,
      categoriesState: categoriesState ?? this.categoriesState,
      categoriesMessage: categoriesMessage ?? this.categoriesMessage,
    );
  }

  @override
  List<Object?> get props => [
    homeSliderItems,
    homeSliderItemsState,
    homeSliderItemsMessage,
    categoriesList,
    categoriesState,
    categoriesMessage,
  ];
}
