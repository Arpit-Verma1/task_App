import 'package:flutter/material.dart';


class TaskCard extends StatelessWidget {
  const TaskCard(
      {super.key, required this.color, required this.headerText, required this.descriptionText});

  final Color color;
  final String headerText;
  final String descriptionText;


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: color,

        borderRadius: BorderRadius.circular(10)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(headerText,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
          Text(descriptionText, style: TextStyle(fontSize: 14),
            maxLines: 4,
            overflow: TextOverflow.ellipsis,)
        ],
      ),
    );
  }
}

