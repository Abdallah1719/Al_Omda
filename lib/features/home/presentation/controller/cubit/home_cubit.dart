import 'package:al_omda/features/home/data/models/home_sliders_model.dart';
import 'package:al_omda/features/home/domain/repository/base_home_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final BaseHomeRepository baseProductsRepository;
  HomeCubit(this.baseProductsRepository) : super(HomeInitial());

  getHomeSliders() async {
    emit(HomeSildersLodding());
    final response = await baseProductsRepository.getHomeSliders();

    response.fold(
      (errorMessage) => emit(HomeSildersFailure(errorMassage: errorMessage)),

      (homeSlidersModel) =>
          emit(HomeSildersSucsess(homeSliders: homeSlidersModel)),
    );
  }
}
