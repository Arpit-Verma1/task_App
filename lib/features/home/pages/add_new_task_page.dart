import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/features/auth/cubit/auth_cubit.dart';
import 'package:frontend/features/home/cubit/taks_cubit.dart';
import 'package:frontend/features/home/pages/home_page.dart';
import 'package:intl/intl.dart';

class AddNewTaskPage extends StatefulWidget {
  static MaterialPageRoute route() =>
      MaterialPageRoute(builder: (context) => AddNewTaskPage());

  const AddNewTaskPage({super.key});

  @override
  State<AddNewTaskPage> createState() => _AddNewTaskPageState();
}

class _AddNewTaskPageState extends State<AddNewTaskPage> {
  DateTime selectedDate = DateTime.now();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  Color selectedColor = const Color.fromRGBO(246, 222, 194, 1);
  final formKey = GlobalKey<FormState>();

  void createNewTask() async {
    if (formKey.currentState!.validate()) {
      AuthLoggedIn user = context.read<AuthCubit>().state as AuthLoggedIn;
      await context.read<TasksCubit>().createNewTask(
            title: titleController.text.trim(),
            description: descriptionController.text.trim(),
            hexColor: selectedColor,
            dueDate: selectedDate,
            token: user.user.token!,
          );
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    descriptionController.dispose();
    titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add New Task"),
        actions: [
          GestureDetector(
            onTap: () async {
              DateTime? _selectedDate = await showDatePicker(
                context: context,
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(
                  Duration(days: 90),
                ),
              );
              if (selectedDate != _selectedDate) {
                setState(() {
                  selectedDate = _selectedDate!;
                });
              }
            },
            child: Padding(
                padding: EdgeInsets.all(8),
                child: Text(DateFormat("MM-d-y").format(selectedDate))),
          )
        ],
      ),
      body: BlocConsumer<TasksCubit, TasksState>(
          builder: (BuildContext context, state) {
        if (state is TasksLoading)
          return const Center(
            child: CircularProgressIndicator(),
          );

        return Padding(
          padding: EdgeInsets.all(8),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Title can not be emoty";
                    }
                    return null;
                  },
                  controller: titleController,
                  decoration: const InputDecoration(hintText: 'Title'),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Description can not be emoty";
                    }
                    return null;
                  },
                  controller: descriptionController,
                  decoration: const InputDecoration(hintText: 'Description'),
                  maxLines: 5,
                ),
                ColorPicker(
                  heading: const Text('Select color'),
                  subheading: const Text('Select SubHeading'),
                  onColorChanged: (Color color) {
                    setState(() {
                      selectedColor = color;
                    });
                  },
                  color: selectedColor,
                  pickersEnabled: {ColorPickerType.wheel: true},
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    createNewTask();
                  },
                  child: Text(
                    'Submit',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                )
              ],
            ),
          ),
        );
      }, listener: (BuildContext context, TasksState state) {
        if (state is TasksError)
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error),
            ),
          );
        else if (state is AddNewTaskSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Task Added successfully"),
            ),
          );
          Navigator.pushAndRemoveUntil(context, HomePage.route(), (_) => false);
        }
      }),
    );
  }
}
