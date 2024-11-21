import 'package:toddo_app/core/utils/app_assets.dart';
import 'package:toddo_app/core/utils/app_strings.dart';

class onBoardingModel {
  final String img;
  final String title;
  final String subTitle;

  onBoardingModel(
      {required this.img, required this.title, required this.subTitle});

  static List<onBoardingModel> onBoardingScreens = [
    onBoardingModel(
        img: AppAssets.onBoardingOne,
        title: AppStrings.onBoardingTitleOne,
        subTitle: AppStrings.onBoardingSubTitleOne),
    onBoardingModel(
        img: AppAssets.onBoardingTwo,
        title: AppStrings.onBoardingTitleTwo,
        subTitle: AppStrings.onBoardingSubTitleTwo),
    onBoardingModel(
        img: AppAssets.onBoardingThree,
        title: AppStrings.onBoardingTitleThree,
        subTitle: AppStrings.onBoardingSubTitleThree),
  ];
}
