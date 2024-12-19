import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/core/constants/utils.dart';
import 'package:frontend/features/home/repository/task_remote_repository.dart';

import '../../../models/task_model.dart';
import '../repository/taks_local_repository.dart';

part 'task_state.dart';

class TasksCubit extends Cubit<TasksState> {
  TasksCubit() : super(TasksInitial());
  final taskRemoteRepository = TasksRemoteRepository();
  final taskLocalRepository = TaksLocalRepository();

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
      await taskLocalRepository.insertTask(taskModel);
      emit(AddNewTaskSuccess(taskModel));
    } catch (e) {
      emit(TasksError(e.toString()));
    }
  }

  Future<List<TaskModel>> getTasks({required String token}) async {
    try {
      emit(TasksLoading());
      final allTasks = await taskRemoteRepository.getTasks(token: token);
      emit(GetTasksSuccess(allTasks));
      return allTasks;

    } catch (e) {
      final tasks = await taskLocalRepository.getTasks();
      if(tasks.isNotEmpty)
        return tasks;
      emit(TasksError(e.toString()));
    }
    return [];
  }
}
