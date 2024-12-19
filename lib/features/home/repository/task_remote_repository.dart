import 'dart:convert';

import 'package:frontend/features/home/repository/taks_local_repository.dart';
import 'package:frontend/models/task_model.dart';
import 'package:http/http.dart' as http;
import 'package:frontend/core/constants/constants.dart';

class TasksRemoteRepository {
  Future<TaskModel> createTask(
      {required String title,
      required String description,
      required String hexColor,
      required DateTime dueDate,
      required String token}) async {
    try {
      String formatedDueDate = dueDate.toIso8601String();
      final res = await http.post(Uri.parse("${Constants.backendURL}/tasks/"),
          headers: {'Content-Type': 'application/json', 'x-auth-token': token},
          body: jsonEncode({
            'title': title,
            'description': description,
            'hexColor': hexColor,
            'dueAt': formatedDueDate
          }));
      print("res body is ${res.body}");

      if (res.statusCode != 201) {
        throw jsonDecode(res.body)['error'];
      }
      return TaskModel.fromJson(
        jsonDecode(res.body),
      );
    } catch (e) {
      throw (e.toString());
    }
  }

  Future<List<TaskModel>> getTasks({required String token}) async {
    final taskLocalRepository = TaksLocalRepository();
    try {
      final res = await http.get(
        Uri.parse("${Constants.backendURL}/tasks/"),
        headers: {'Content-Type': 'application/json', 'x-auth-token': token},
      );

      if (res.statusCode != 200) {
        throw jsonDecode(res.body)['error'];
      }
      final listOfTasks = jsonDecode(res.body);
      List<TaskModel> allTask = [];

      for (var elem in listOfTasks) {
        allTask.add(TaskModel.fromJson(elem));
      }

      await taskLocalRepository.insertTasks(allTask);
      return allTask;
    } catch (e) {

      throw (e.toString());
    }
  }
}
