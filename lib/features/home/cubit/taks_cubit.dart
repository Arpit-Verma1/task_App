import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/core/constants/utils.dart';
import 'package:frontend/features/home/repository/task_remote_repository.dart';

import '../../../models/task_model.dart';

part 'task_state.dart';

class TasksCubit extends Cubit<TasksState> {
  TasksCubit() : super(TasksInitial());
  final taskRemoteRepository = TasksRemoteRepository();

  Future<void> createNewTask(
      {required String title,
      required String description,
      required Color hexColor,
      required DateTime dueDate,
      required String token}) async {
    try {
      emit(TasksLoading());
      final taskModel = await taskRemoteRepository.createTask(
          title: title,
          description: description,
          hexColor: rgbToHex(hexColor),
          dueDate: dueDate,
          token: token);
      emit(AddNewTaskSuccess(taskModel));
    } catch (e) {
      emit(TasksError(e.toString()));
    }
  }

  Future<void> getTasks({required String token}) async {
    try {
      emit(TasksLoading());
      final allTasks = await taskRemoteRepository.getTasks(token: token);
      emit(GetTasksSuccess(allTasks));
    } catch (e) {
      emit(TasksError(e.toString()));
    }
  }
}
