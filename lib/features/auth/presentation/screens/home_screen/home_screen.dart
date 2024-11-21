import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:toddo_app/core/utils/app_assets.dart';
import 'package:toddo_app/core/utils/app_colors.dart';
import 'package:toddo_app/core/utils/app_strings.dart';
import 'package:toddo_app/core/widgets/custom_elevated_button.dart';
import 'package:toddo_app/features/auth/data/models/tasks_model.dart';
import 'package:toddo_app/features/auth/presentation/cubit/cubit/task_cubit.dart';
import 'package:toddo_app/features/auth/presentation/cubit/cubit/task_state.dart';

import '../add_tast_screen/add_task_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: BlocBuilder<TaskCubit, TaskState>(
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      DateFormat().add_yMMMMd().format(DateTime.now()),
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        BlocProvider.of<TaskCubit>(context).changeTheme();
                      },
                      icon: Icon(
                        Icons.mode_night,
                        color: BlocProvider.of<TaskCubit>(context).isDark
                            ? AppColors.white
                            : AppColors.background,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 12.h,
                ),
                Text(
                  AppStrings.today,
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                SizedBox(
                  height: 6.h,
                ),
                DatePicker(
                  DateTime.now(),
                  initialSelectedDate: DateTime.now(),
                  selectionColor: AppColors.primary,
                  selectedTextColor: AppColors.white,
                  dateTextStyle: Theme.of(context).textTheme.displayMedium!,
                  dayTextStyle: Theme.of(context).textTheme.displayMedium!,
                  monthTextStyle: Theme.of(context).textTheme.displayMedium!,
                  onDateChange: (date) {
                    BlocProvider.of<TaskCubit>(context).getselectedDate(date);
                  },
                ),
                BlocProvider.of<TaskCubit>(context).tasksList.isEmpty
                    ? noTaskWidget(context)
                    : Expanded(
                        child: ListView.builder(
                            itemCount: BlocProvider.of<TaskCubit>(context)
                                .tasksList
                                .length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  showModalBottomSheet(
                                      context: context,
                                      builder: (context) {
                                        return Container(
                                          padding: const EdgeInsets.all(24),
                                          height: 240.h,
                                          width: double.infinity,
                                          color: AppColors.deepGrey,
                                          child: Column(
                                            children: [
                                              // Task Completed
                                              BlocProvider.of<TaskCubit>(
                                                              context)
                                                          .tasksList[index]
                                                          .isCompleted ==
                                                      1
                                                  ? Container()
                                                  : SizedBox(
                                                      height: 48.h,
                                                      width: double.infinity,
                                                      child:
                                                          CustomElevatedButton(
                                                        onPressed: () {
                                                          BlocProvider.of<
                                                                      TaskCubit>(
                                                                  context)
                                                              .updateTask(BlocProvider
                                                                      .of<TaskCubit>(
                                                                          context)
                                                                  .tasksList[
                                                                      index]
                                                                  .id);
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        text: AppStrings
                                                            .taskCompleted,
                                                      ),
                                                    ),
                                              SizedBox(
                                                height: 24.h,
                                              ),
                                              //Delete Task
                                              SizedBox(
                                                height: 48.h,
                                                width: double.infinity,
                                                child: CustomElevatedButton(
                                                  onPressed: () {
                                                    BlocProvider.of<TaskCubit>(
                                                            context)
                                                        .deleteTask(
                                                      BlocProvider.of<
                                                                  TaskCubit>(
                                                              context)
                                                          .tasksList[index]
                                                          .id,
                                                    );
                                                    Navigator.pop(context);
                                                  },
                                                  text: AppStrings.deleteTask,
                                                  backGroundColor:
                                                      AppColors.red,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 24.h,
                                              ),
                                              //cancel Task
                                              SizedBox(
                                                height: 48.h,
                                                width: double.infinity,
                                                child: CustomElevatedButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  text: AppStrings.cancel,
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      });
                                },
                                child: TaskComponents(
                                  taskModel: BlocProvider.of<TaskCubit>(context)
                                      .tasksList[index],
                                ),
                              );
                            }),
                      ),
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {
              return AddTaskScreen();
            }),
          );
        },
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add),
      ),
    ));
  }

  Column noTaskWidget(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          height: 301.h,
          width: 277.w,
          AppAssets.noTask,
        ),
        SizedBox(
          height: 10.h,
        ),
        Text(
          AppStrings.noTaskTitle,
          style: Theme.of(context).textTheme.displayMedium!.copyWith(
                fontSize: 25.sp,
              ),
        ),
        SizedBox(
          height: 10.h,
        ),
        Text(
          AppStrings.noTastSubTitle,
          style: Theme.of(context).textTheme.displayMedium,
        ),
      ],
    );
  }
}

class TaskComponents extends StatelessWidget {
  const TaskComponents({
    super.key,
    required this.taskModel,
  });

  final TaskModel taskModel;

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

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 132.h,
        padding: const EdgeInsets.all(8),
        margin: EdgeInsets.only(bottom: 14.h, top: 14.h),
        decoration: BoxDecoration(
          color: getColor(taskModel.color),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    taskModel.title,
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.timer,
                        color: AppColors.white,
                      ),
                      SizedBox(
                        width: 8.h,
                      ),
                      Text(
                        '${taskModel.startTime} - ${taskModel.endTime} PM',
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    taskModel.note,
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                ],
              ),
            ),
            Container(
              height: 75.h,
              width: 1.w,
              color: AppColors.white,
              margin: const EdgeInsets.only(right: 10),
            ),
            RotatedBox(
              quarterTurns: 3,
              child: Text(
                taskModel.isCompleted == 1
                    ? AppStrings.completed
                    : AppStrings.todo,
                style: Theme.of(context).textTheme.displayMedium,
              ),
            ),
          ],
        ));
  }
}
