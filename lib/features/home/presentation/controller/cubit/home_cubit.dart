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

  Future<void> getHomeProductsTopRated() async {
    emit(state.copyWith(productsTopRatedState: RequestState.loading));

    final result = await baseHomeRepository.getHomeProductsTopRated();

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
