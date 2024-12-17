import 'package:flutter/material.dart';

class DateSelector extends StatefulWidget {
  const DateSelector({super.key});

  @override
  State<DateSelector> createState() => _DateSelectorState();
}

class _DateSelectorState extends State<DateSelector> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            IconButton(onPressed: (){}, icon: Icon(Icons.arrow_back_ios)),
            Text("January"),
            IconButton(onPressed: (){}, icon: Icon(Icons.arrow_forward)),
          ],
        )
      ],
    );
  }
}
