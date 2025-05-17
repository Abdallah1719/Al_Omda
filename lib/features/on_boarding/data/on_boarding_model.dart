import 'package:al_omda/core/utils/app_assets.dart';

class OnBoardingModel {
  final String image;
  final String onBoadingTitle;
  final String onBoardingText;

  OnBoardingModel({
    required this.image,
    required this.onBoadingTitle,
    required this.onBoardingText,
  });
}

List<OnBoardingModel> onBoardingList = [
  OnBoardingModel(
    image: Assets.imagesOnboarding1,
    onBoadingTitle: 'E shopping',
    onBoardingText: 'Explore top organic fruits & grab them',
  ),
  OnBoardingModel(
    image: Assets.imagesOnboarding2,
    onBoadingTitle: 'Delivery on the way',
    onBoardingText: 'Get your order by speed delivery',
  ),
  OnBoardingModel(
    image: Assets.imagesOnboarding3,
    onBoadingTitle: 'Delivery Arrived',
    onBoardingText: 'Order is arrived at your place',
  ),
];
