import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/utils/app_colors.dart';

class AddTaskComponents extends StatelessWidget {
  AddTaskComponents({
    super.key,
    required this.title,
    required this.controller,
    required this.hintText,
    this.suffixIcon,
    this.readOnly = false,
    this.validator,
  });

  final String title;
  final TextEditingController controller;
  final String hintText;
  final IconButton? suffixIcon;
  final bool readOnly;
  String? Function(String?)? validator;
  bool? isDark;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.displayMedium,
        ),
        SizedBox(height: 8.h),
        TextFormField(
          style: TextStyle(
            color: AppColors.white,
          ),
          validator: validator,
          readOnly: readOnly,
          controller: controller,
          decoration: InputDecoration(
            hintText: hintText,
            suffixIcon: suffixIcon,
          ),
        ),
      ],
    );
  }
}
