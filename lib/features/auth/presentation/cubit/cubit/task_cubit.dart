import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:toddo_app/core/database/cache_helper.dart';
import 'package:toddo_app/core/database/sqflite_helper/sqflite_helper.dart';
import 'package:toddo_app/core/services/services_locater.dart';
import 'package:toddo_app/core/utils/app_colors.dart';

import '../../../data/models/tasks_model.dart';
import 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  TaskCubit() : super(TaskInitial());
  TextEditingController titleController = TextEditingController();

  TextEditingController noteController = TextEditingController();

  TextEditingController dateController = TextEditingController();

  TextEditingController startTimeController = TextEditingController();

  TextEditingController endTimeController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey();

  DateTime currentDate = DateTime.now();
  DateTime selctedDate = DateTime.now();
  String startTime = DateFormat('hh:mm a').format(DateTime.now());
  String endTime = DateFormat('hh:mm a')
      .format(DateTime.now().add(const Duration(minutes: 45)));
  int currentIndex = 0;

  void getDate(context) async {
    emit(getDateLoadingState());
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2025),
    );
    if (pickedDate != null) {
      currentDate = pickedDate;
      emit(getDateSucessState());
    } else {
      emit(getDateErrorState());
    }
  }

  void getStartTime(context) async {
    emit(startTimeLoadingState());
    TimeOfDay? pickedStartTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(DateTime.now()),
    );
    if (pickedStartTime != null) {
      startTime = pickedStartTime.format(context);
      emit(startTimeSucessState());
    } else {
      emit(startTimeErrorState());
    }
  }

  void getEndTime(context) async {
    emit(endTimeLoadingState());
    TimeOfDay? picedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(DateTime.now()),
    );
    if (picedTime != null) {
      endTime = picedTime.format(context);
      emit(endTimeSucessState());
    } else {
      emit(endTimeErrorState());
    }
  }

  Color getColor(index) {
    switch (index) {
      case 0:
        return AppColors.red;
      case 1:
        return AppColors.green;
      case 2:
        return AppColors.bluegreen;
      case 3:
        return AppColors.blue;
      case 4:
        return AppColors.orange;
      case 5:
        return AppColors.purple;
      default:
        return AppColors.grey;
    }
  }

  void changeMarkIndex(index) {
    currentIndex = index;
    emit(ChangeMarkIndexState());
  }

  bool isDark = false;

  void changeTheme() async {
    isDark = !isDark;
    await sl<CacheHelper>().saveData(key: 'isDark', value: isDark);
    emit(changeThemeState());
  }

  void getTheme() async {
    if (sl<CacheHelper>().getData(key: 'isDark') == null) {
      sl<CacheHelper>().saveData(key: 'isDark', value: false);
    }
    isDark = await sl<CacheHelper>().getData(key: 'isDark');
    emit(getThemeState());
  }

  void getselectedDate(date) {
    emit(selectedDateLoadingState());
    selctedDate = date;
    emit(selectedDateerrorState());
    getTasks();
  }

  List<TaskModel> tasksList = [];

  void insertTask() async {
    emit(instertLoadingState());

    try {
      sl<sqfliteHelper>().insertToDB(
        TaskModel(
          date: DateFormat.yMd().format(currentDate),
          title: titleController.text,
          note: noteController.text,
          startTime: startTime,
          endTime: endTime,
          isCompleted: 0,
          color: currentIndex,
        ),
      );

      // await Future.delayed(Duration(seconds: 1));
      // tasksList.add(TaskModel(
      //   date: DateFormat.yMd().format(currentDate),
      //   title: titleController.text,
      //   note: noteController.text,
      //   startTime: startTime,
      //   endTime: endTime,
      //   isCompleted: false,
      //   color: currentIndex,
      // ));
      titleController.clear();
      noteController.clear();
      emit(instertsuccessState());
      getTasks();
    } catch (e) {
      emit(instertErrorState());
    }
  }

  void getTasks() async {
    emit(getDataLoadingState());
    await sl<sqfliteHelper>().getFromDb().then((value) {
      tasksList = value
          .map((e) => TaskModel.fromJson(e))
          .toList()
          .where(
              (element) => element.date == DateFormat.yMd().format(selctedDate))
          .toList();
      emit(getDatasuccessState());
    });
    emit(getDataErrorState());
  }

  void updateTask(id) {
    emit(updateDataLoadingState());
    sl<sqfliteHelper>().updateDb(id).then((value) {
      emit(updateDatasuccessState());
      getTasks();
    }).catchError((e) {
      emit(updateDataErrorState());
    });
  }

  void deleteTask(id) {
    emit(deleteDataLoadingState());
    sl<sqfliteHelper>().deleteFromDB(id).then((value) {
      emit(deleteDatasuccessState());
      getTasks();
    }).catchError((e) {
      emit(deleteDataErrorState());
    });
  }
}
