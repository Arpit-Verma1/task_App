import 'package:flutter/material.dart';
import 'package:frontend/core/constants/utils.dart';
import 'package:intl/intl.dart';

class DateSelector extends StatefulWidget {
  const DateSelector({super.key});

  @override
  State<DateSelector> createState() => _DateSelectorState();
}

class _DateSelectorState extends State<DateSelector> {
  int weeKOffsets = 0;
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final weekDays = generateWeekDates(weeKOffsets);
    String monthName = DateFormat("MMMM").format(weekDays.first);

    return Column(
      children: [
        Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: 15).copyWith(bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    weeKOffsets--;
                  });
                },
                icon: Icon(Icons.arrow_back_ios),
              ),
              Text(
                monthName,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    weeKOffsets++;
                  });
                },
                icon: Icon(Icons.arrow_forward),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SizedBox(
            height: 70,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: weekDays.length,
                itemBuilder: (context, index) {
                  final date = weekDays[index];
                  bool isSelected = DateFormat('d').format(selectedDate) ==
                          DateFormat('d').format(date) &&
                      selectedDate.month == date.month &&
                      selectedDate.year == date.year;

                  return GestureDetector(
                    onTap: () {
                      setState(() {

                        selectedDate =date;
                      });
                    },
                    child: Container(
                      width: 70,
                      margin: EdgeInsets.only(right: 8),
                      decoration: BoxDecoration(
                        color:  isSelected ? Colors.orange:Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.fromBorderSide(
                          BorderSide(
                              color:isSelected ?Colors.deepOrangeAccent:
                          Colors.grey.shade300, width: 2),
                        ),
                      ),
                      height: 50,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            DateFormat('d').format(date),
                            style: TextStyle(
                              color: isSelected ?Colors.white:Colors.black,
                                fontWeight: FontWeight.bold, fontSize: 22),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            DateFormat("E").format(date),
                            style: TextStyle(
                              color: isSelected ?Colors.white:Colors.black,
                                fontWeight: FontWeight.bold, fontSize: 16),
                          )
                        ],
                      ),
                    ),
                  );
                }),
          ),
        )
      ],
    );
  }
}
