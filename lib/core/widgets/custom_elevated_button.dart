import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class CustomElevatedButton extends StatelessWidget {
   CustomElevatedButton(
      {super.key, required this.onPressed, required this.text , this.backGroundColor = AppColors.primary});

  final VoidCallback onPressed;
  final String text;
  Color backGroundColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          color: AppColors.white,
        ),
      ),
      style: Theme.of(context)
          .elevatedButtonTheme
          .style!
          .copyWith(backgroundColor: MaterialStatePropertyAll(backGroundColor)),
    );
  }
}
