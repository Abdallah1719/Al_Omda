import 'package:al_omda/core/utils/enum.dart';
import 'package:al_omda/features/home/domain/repository/base_home_repository.dart';
import 'package:al_omda/features/home/presentation/controller/cubit/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeState> {
  final BaseHomeRepository baseHomeRepository;

  HomeCubit(this.baseHomeRepository) : super(HomeState());

  Future<void> getHomeSliderItems() async {
    emit(state.copyWith(homeSliderItemsState: RequestState.loading));

    final result = await baseHomeRepository.getHomeSliderItems();

    result.fold(
      (failure) => emit(
        state.copyWith(
          homeSliderItemsState: RequestState.error,
          homeSliderItemsMessage: failure,
        ),
      ),
      (sliderItems) => emit(
        state.copyWith(
          homeSliderItems: sliderItems,
          homeSliderItemsState: RequestState.loaded,
        ),
      ),
    );
  }

  Future<void> getHomeCategories() async {
    // if (isClosed) return;

    emit(state.copyWith(categoriesState: RequestState.loading));

    final result = await baseHomeRepository.getHomeCategories();

    // if (isClosed) return;

    result.fold(
      (failure) {
        // if (isClosed) return;
        emit(
          state.copyWith(
            categoriesState: RequestState.error,
            categoriesMessage: failure,
          ),
        );
      },
      (categories) {
        // if (isClosed) return;
        emit(
          state.copyWith(
            categoriesState: RequestState.loaded,
            categories: categories,
          ),
        );
      },
    );
  }
}
