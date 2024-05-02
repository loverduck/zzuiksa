import 'package:client/screens/schedule/schedule_add_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:client/constants.dart';
import 'package:client/screens/schedule/widgets/calendar.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime? selectedDay;

  void moveToDetail() {
    Navigator.pushNamed(context, '/schedule/detail');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 8),
          child: Calendar(
            foucsedDay: DateTime.now(),
            onDaySelected: onDaySelected,
            selectedDayPredicate: selectedDayPredicate,
          ),
        ),
      ),
    );
  }

  // 캘린더에서 날짜 클릭 시 다이얼로그 오픈
  void onDaySelected(DateTime selectedDay, DateTime foucsedDay) {
    setState(() {
      this.selectedDay = selectedDay;
    });

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          titlePadding:
              const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
          // titlePadding: const EdgeInsets.fromLTRB(16, 20, 16, 10),
          contentPadding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
          backgroundColor: Constants.main200,
          shape: RoundedRectangleBorder(
            side: const BorderSide(
              color: Colors.black,
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text(
            DateFormat("MM월 dd일").format(selectedDay),
            style: const TextStyle(
              fontSize: 20.0,
            ),
          ),
          content: SizedBox(
            height: 300,
            child: Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  GestureDetector(
                    onTap: moveToDetail,
                    child: const Text("할일 1"),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("할 일을 입력해주세요"),
                      Transform.translate(
                        offset: const Offset(8, 0),
                        child: IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return ScheduleAddScreen(
                                    selectedDay: selectedDay,
                                  );
                                },
                              ),
                            );
                          },
                          icon: const Icon(
                            Icons.add_circle,
                            color: Constants.main600,
                            size: 36.0,
                          ),
                          padding: const EdgeInsets.all(0),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  bool selectedDayPredicate(DateTime date) {
    if (selectedDay == null) {
      return false;
    }

    return date.isAtSameMomentAs(selectedDay!);
  }
}
