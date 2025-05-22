part of 'home_cubit.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

final class HomeInitial extends HomeState {}

final class HomeSildersLodding extends HomeState {}

final class HomeSildersSucsess extends HomeState {
  final List<HomeSlidersModel> homeSliders;

  const HomeSildersSucsess({required this.homeSliders});
}

final class HomeSildersFailure extends HomeState {
  final String errorMassage;

  const HomeSildersFailure({required this.errorMassage});
}
