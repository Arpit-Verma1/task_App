import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/core/constants/utils.dart';
import 'package:frontend/features/home/widgets/date_selector.dart';
import 'package:frontend/features/home/widgets/task_card.dart';

class HomePage extends StatefulWidget {
  static MaterialPageRoute route() =>
      MaterialPageRoute(builder: (context) => HomePage());

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('My Tasks'),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(CupertinoIcons.add),
            ),
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DateSelector(),
            Row(
              children: [
                Expanded(
                  child: TaskCard(
                      color: Color.fromRGBO(246, 222, 194, 1),
                      headerText: "asd",
                      descriptionText: "ada"),
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
                  child: Text("10:00 Am",style: TextStyle(fontSize: 14,),),
                )
              ],
            )
          ],
        ));
  }
}
