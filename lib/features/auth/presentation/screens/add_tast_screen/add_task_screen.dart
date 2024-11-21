import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:toddo_app/core/commons/commons.dart';
import 'package:toddo_app/core/utils/app_colors.dart';
import 'package:toddo_app/core/widgets/custom_elevated_button.dart';
import 'package:toddo_app/features/auth/presentation/components/add_task_components.dart/add_task_components.dart';
import 'package:toddo_app/features/auth/presentation/cubit/cubit/task_cubit.dart';
import 'package:toddo_app/features/auth/presentation/cubit/cubit/task_state.dart';

import '../../../../../core/utils/app_strings.dart';

class AddTaskScreen extends StatelessWidget {
  const AddTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_new_outlined,
            color: BlocProvider.of<TaskCubit>(context).isDark
                ? AppColors.white
                : AppColors.background,
          ),
          color: AppColors.white,
        ),
        title: Text(
          'Add Task',
          style: Theme.of(context).textTheme.displayLarge,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: BlocConsumer<TaskCubit, TaskState>(
            listener: (context, state) {
              if (state is instertsuccessState) {
                showToast(
                  message: 'Note Added Sucssefly',
                  state: toastState.sucess,
                );
                Navigator.pop(context);
              }
            },
            builder: (context, state) {
              return Form(
                key: BlocProvider.of<TaskCubit>(context).formKey,
                child: Column(
                  children: [
                    //! title
                    AddTaskComponents(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'must be not empty';
                        }
                        return null;
                      },
                      title: AppStrings.title,
                      controller:
                          BlocProvider.of<TaskCubit>(context).titleController,
                      hintText: AppStrings.titleHint,
                    ),
                    SizedBox(
                      height: 24.h,
                    ),
                    //! Note

                    AddTaskComponents(
                      title: AppStrings.note,
                      controller:
                          BlocProvider.of<TaskCubit>(context).noteController,
                      hintText: AppStrings.noteHint,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'must be not empty';
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(
                      height: 24.h,
                    ),
                    //! Date
                    AddTaskComponents(
                      title: AppStrings.date,
                      controller:
                          BlocProvider.of<TaskCubit>(context).dateController,
                      hintText: DateFormat.yMd().format(
                          BlocProvider.of<TaskCubit>(context).currentDate),
                      suffixIcon: IconButton(
                        onPressed: () async {
                          BlocProvider.of<TaskCubit>(context).getDate(context);
                        },
                        icon: Icon(Icons.calendar_month_outlined),
                        color: AppColors.white,
                      ),
                      readOnly: true,
                    ),
                    //! Time - EndTime
                    SizedBox(
                      height: 24.h,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: AddTaskComponents(
                            title: AppStrings.startTime,
                            controller: BlocProvider.of<TaskCubit>(context)
                                .startTimeController,
                            hintText:
                                BlocProvider.of<TaskCubit>(context).startTime,
                            suffixIcon: IconButton(
                              onPressed: () async {
                                BlocProvider.of<TaskCubit>(context)
                                    .getStartTime(context);
                              },
                              icon: Icon(
                                Icons.timer_outlined,
                                color: AppColors.white,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 24.w,
                        ),
                        Expanded(
                          child: AddTaskComponents(
                            title: AppStrings.endTime,
                            controller: BlocProvider.of<TaskCubit>(context)
                                .endTimeController,
                            hintText:
                                BlocProvider.of<TaskCubit>(context).endTime,
                            suffixIcon: IconButton(
                              onPressed: () async {
                                BlocProvider.of<TaskCubit>(context)
                                    .getEndTime(context);
                              },
                              icon: Icon(
                                Icons.timer_outlined,
                                color: AppColors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 24.h,
                    ),
                    SizedBox(
                      height: 68.h,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppStrings.color,
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          Expanded(
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    BlocProvider.of<TaskCubit>(context)
                                        .changeMarkIndex(index);
                                  },
                                  child: CircleAvatar(
                                    backgroundColor:
                                        BlocProvider.of<TaskCubit>(context)
                                            .getColor(index),
                                    child: index ==
                                            BlocProvider.of<TaskCubit>(context)
                                                .currentIndex
                                        ? Icon(
                                            Icons.check,
                                            color: AppColors.white,
                                          )
                                        : null,
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) {
                                return SizedBox(
                                  width: 8,
                                );
                              },
                              itemCount: 6,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 90.h,
                    ),
                    state is instertLoadingState
                        ? Center(
                            child: CircularProgressIndicator(
                            color: AppColors.primary,
                          ))
                        : SizedBox(
                            width: double.infinity,
                            height: 48.h,
                            child: CustomElevatedButton(
                              onPressed: () {
                                if (BlocProvider.of<TaskCubit>(context)
                                    .formKey
                                    .currentState!
                                    .validate()) {
                                  BlocProvider.of<TaskCubit>(context)
                                      .insertTask();
                                }
                              },
                              text: AppStrings.createTask,
                            ),
                          ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
