import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toddo_app/core/database/cache_helper.dart';
import 'package:toddo_app/core/services/services_locater.dart';
import 'package:toddo_app/core/utils/app_assets.dart';
import 'package:toddo_app/core/utils/app_colors.dart';
import 'package:toddo_app/features/auth/presentation/screens/home_screen/home_screen.dart';
import 'package:toddo_app/features/auth/presentation/screens/on_boarding/on_baording_screen.dart';

import '../../../../../core/utils/app_strings.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navigate();
  }

  void navigate() {
    bool isVisted =
        sl<CacheHelper>().getData(key: AppStrings.onBoardingKey) ?? false;
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => isVisted ? const HomeScreen() : OnBoardingScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(AppAssets.logo),
            const SizedBox(
              height: 24,
            ),
            Text(
              AppStrings.splashTitle,
              style: GoogleFonts.lato(
                color: AppColors.white,
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
