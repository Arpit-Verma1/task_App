import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/core/constants/utils.dart';
import 'package:frontend/features/auth/cubit/auth_cubit.dart';
import 'package:frontend/features/home/cubit/taks_cubit.dart';
import 'package:frontend/features/home/pages/add_new_task_page.dart';
import 'package:frontend/features/home/widgets/date_selector.dart';
import 'package:frontend/features/home/widgets/task_card.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  static MaterialPageRoute route() =>
      MaterialPageRoute(builder: (context) => HomePage());

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    final user = context.read<AuthCubit>().state as AuthLoggedIn;
    context.read<TasksCubit>().getTasks(token: user.user.token!);
    Connectivity().onConnectivityChanged.listen((data)async{
      if(data.contains(ConnectivityResult.wifi)) {
        await context.read<TasksCubit>().syncTask(user.user.token!);
      }
    });
  }

  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('My Tasks'),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(context, AddNewTaskPage.route());
              },
              icon: const Icon(CupertinoIcons.add),
            ),
          ],
        ),
        body: BlocBuilder<TasksCubit, TasksState>(builder: (context, state) {
          if (state is TasksLoading)
            return Center(
              child: CircularProgressIndicator(),
            );
          if (state is TasksError)
            return Center(
              child: Text(state.error),
            );
          if (state is GetTasksSuccess) {
            final tasks = state.tasks
                .where((task) =>
                    DateFormat('d').format(selectedDate) ==
                        DateFormat('d').format(task.dueAt!) &&
                    selectedDate.month == task.dueAt!.month &&
                    selectedDate.year == task.dueAt!.year)
                .toList();
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DateSelector(
                  selectedDate: selectedDate,
                  onTap: (date) {
                    setState(() {
                      selectedDate = date;
                    });
                  },
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: tasks.length,
                    itemBuilder: (BuildContext context, int index) {
                      final task = tasks[index];
                      return Row(
                        children: [
                          Expanded(
                            child: TaskCard(
                                color: task.color!,
                                headerText: task.title!,
                                descriptionText: task.description!),
                          ),
                          Container(
                            height: 10,
                            width: 10,
                            decoration: BoxDecoration(
                                color: strengthenColor(
                                    Color.fromRGBO(246, 222, 194, 1), 0.69),
                                shape: BoxShape.circle),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                              DateFormat.jm().format(task.dueAt!),
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          )
                        ],
                      );
                    },
                  ),
                )
              ],
            );
          }
          return Container();
        }));
  }
}
