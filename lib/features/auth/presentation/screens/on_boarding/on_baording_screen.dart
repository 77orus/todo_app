import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:toddo_app/core/database/cache_helper.dart';
import 'package:toddo_app/core/utils/app_colors.dart';
import 'package:toddo_app/core/widgets/custom_elevated_button.dart';
import 'package:toddo_app/core/widgets/custom_text_button.dart';
import 'package:toddo_app/features/auth/data/models/on_boarding_model.dart';
import 'package:toddo_app/features/auth/presentation/screens/home_screen/home_screen.dart';

import '../../../../../core/services/services_locater.dart';
import '../../../../../core/utils/app_strings.dart';

class OnBoardingScreen extends StatelessWidget {
  OnBoardingScreen({super.key});

  PageController controller = PageController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: Padding(
          padding: const EdgeInsets.all(24),
          child: PageView.builder(
            controller: controller,
            itemCount: onBoardingModel.onBoardingScreens.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: index == 2
                        ? const SizedBox(
                            height: 50,
                          )
                        : CustomTextButton(
                            onPressed: () {
                              controller.jumpToPage(2);
                            },
                            text: AppStrings.skip,
                          ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Image.asset(onBoardingModel.onBoardingScreens[index].img),
                  const SizedBox(
                    height: 16,
                  ),
                  SmoothPageIndicator(
                    controller: controller,
                    count: 3,
                    effect: const ExpandingDotsEffect(
                      activeDotColor: AppColors.primary,
                      dotHeight: 4,
                      dotWidth: 10,
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Text(
                    onBoardingModel.onBoardingScreens[index].title,
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  const SizedBox(
                    height: 42,
                  ),
                  Text(
                    onBoardingModel.onBoardingScreens[index].subTitle,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  const SizedBox(
                    height: 105,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      index != 0
                          ? CustomTextButton(
                              onPressed: () {
                                controller.previousPage(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                );
                              },
                              text: AppStrings.back,
                            )
                          : Container(),
                      index != 2
                          ? CustomElevatedButton(
                              onPressed: () {
                                controller.nextPage(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                );
                              },
                              text: AppStrings.next,
                            )
                          : CustomElevatedButton(
                              onPressed: () async {
                                await sl<CacheHelper>()
                                    .saveData(
                                        key: AppStrings.onBoardingKey,
                                        value: true)
                                    .then((value) {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => const HomeScreen()));
                                });
                              },
                              text: AppStrings.getStarted)
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
