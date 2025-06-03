import 'package:al_omda/core/utils/enum.dart';
import 'package:al_omda/features/home/domain/repository/base_home_repository.dart';
import 'package:al_omda/features/home/presentation/controller/cubit/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
          homeSlidersMessage: failure,
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
    if (isClosed) return;

    emit(state.copyWith(categoriesState: RequestState.loading));

    final result = await baseHomeRepository.getHomeCategories();

    if (isClosed) return;

    result.fold(
      (failure) {
        if (isClosed) return;
        emit(
          state.copyWith(
            categoriesState: RequestState.error,
            categoriesMessage: failure,
          ),
        );
      },
      (categories) {
        if (isClosed) return;
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
