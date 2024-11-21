import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toddo_app/app/app.dart';
import 'package:toddo_app/core/database/cache_helper.dart';
import 'package:toddo_app/core/services/services_locater.dart';
import 'package:toddo_app/features/auth/presentation/cubit/cubit/task_cubit.dart';

import 'core/bloc/bloc_observer.dart';
import 'core/database/sqflite_helper/sqflite_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await setup();
  await sl<CacheHelper>().init();
  await sl<sqfliteHelper>().initdb();

  runApp(
    BlocProvider(
      create: (context) => TaskCubit()
        ..getTheme()
        ..getTasks(),
      child: const MyApp(),
    ),
  );
}
