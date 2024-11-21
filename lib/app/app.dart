import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toddo_app/core/utils/theme.dart';
import 'package:toddo_app/features/auth/presentation/cubit/cubit/task_cubit.dart';
import 'package:toddo_app/features/auth/presentation/cubit/cubit/task_state.dart';
import 'package:toddo_app/features/auth/presentation/screens/splash_Screen/splash_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) {
          return BlocBuilder<TaskCubit, TaskState>(
            builder: (context, state) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: getAppTheme(),
                darkTheme: getAppDarkTheme(),
                themeMode: BlocProvider.of<TaskCubit>(context).isDark
                    ? ThemeMode.dark
                    : ThemeMode.light,
                home: const SplashScreen(),
              );
            },
          );
        });
  }
}
