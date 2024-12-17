import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
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
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            TextFormField(
              controller: titleController,
              decoration: const InputDecoration(hintText: 'Title'),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
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
              onPressed: () {},
              child: Text(
                'Submit',
                style: TextStyle(color: Colors.white,fontSize: 18),
              ),
            )
          ],
        ),
      ),
    );
  }
}
