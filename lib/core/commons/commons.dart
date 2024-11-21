import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:toddo_app/core/utils/app_colors.dart';

void showToast({
  required String message,
  required toastState state,
}) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: getState(state),
      textColor: Colors.white,
      fontSize: 16.0);
}

enum toastState { error, sucess, warning }

Color getState(toastState state) {
  switch (state) {
    case toastState.error:
      return AppColors.red;
    case toastState.sucess:
      return AppColors.green;
    case toastState.warning:
      return AppColors.orange;
  }
}




