import 'package:al_omda/core/utils/enum.dart';
import 'package:al_omda/features/home/domain/repository/base_home_repository.dart';
import 'package:al_omda/features/home/presentation/controller/cubit/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// part 'home_state.dart';

// class HomeCubit extends Cubit<HomeState> {
//   final BaseHomeRepository basehomeRepository;
//   HomeCubit(this.basehomeRepository) : super(HomeInitial());

//   getHomeSliders() async {
//     emit(HomeSildersLodding());
//     final response = await basehomeRepository.getHomeSliders();

//     response.fold(
//       (errorMessage) => emit(HomeSildersFailure(errorMassage: errorMessage)),

//       (homeSlidersModel) =>
//           emit(HomeSildersSucsess(homeSliders: homeSlidersModel)),
//     );
//   }

//   getHomeCategories() async {
//     final response = await basehomeRepository.getHomeCategories();
//     response.fold(
//       (errorMessage) => emit(HomeCategoriesFailure(errorMassage: errorMessage)),
//       (homeCategoriesModel) =>
//           emit(HomeCategoriesSucsess(homeCategories: homeCategoriesModel)),
//     );
//   }
// }

class HomeCubit extends Cubit<HomeState> {
  final BaseHomeRepository baseHomeRepository;

  HomeCubit(this.baseHomeRepository) : super(HomeState());

  Future<void> getHomeSliders() async {
    emit(state.copyWith(homeSlidersState: RequestState.loading));

    final result = await baseHomeRepository.getHomeSliders();

    result.fold(
      (failure) => emit(
        state.copyWith(
          homeSlidersState: RequestState.error,
          homeSlidersMessage: 'failure.message',
        ),
      ),
      (sliders) => emit(
        state.copyWith(
          homeSliders: sliders,
          homeSlidersState: RequestState.loaded,
        ),
      ),
    );
  }

  Future<void> getHomeCategories() async {
    emit(state.copyWith(categoriesState: RequestState.loading));

    final result = await baseHomeRepository.getHomeCategories();

    result.fold(
      (failure) => emit(
        state.copyWith(
          categoriesState: RequestState.error,
          categoriesMessage: 'failure.message',
        ),
      ),
      (categories) => emit(
        state.copyWith(
          categories: categories,
          categoriesState: RequestState.loaded,
        ),
      ),
    );
  }

  Future<void> getProductsTopRated() async {
    emit(state.copyWith(productsTopRatedState: RequestState.loading));

    final result = await baseHomeRepository.getProductsTopRated();

    result.fold(
      (failure) => emit(
        state.copyWith(
          productsTopRatedState: RequestState.error,
          productsTopRatedMessage: 'failure.message',
        ),
      ),
      (productsTopRated) => emit(
        state.copyWith(
          productsTopRated: productsTopRated,
          productsTopRatedState: RequestState.loaded,
        ),
      ),
    );
  }
}
