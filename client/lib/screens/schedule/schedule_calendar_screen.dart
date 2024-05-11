import 'package:client/screens/schedule/model/schedule_model.dart';
import 'package:client/screens/schedule/schedule_form_screen.dart';
import 'package:client/screens/schedule/service/schedule_api.dart';
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
  Map<DateTime, List<Schedule>> monthSchedules = {};

  void moveToDetail(int scheduleId) {
    Navigator.pushNamed(context, '/schedule/detail');
  }

  void onChangeMonth(day) {
    getMonthSchdulesData(
        DateFormat("yyyy-MM-dd").format(DateTime(day.year, day.month, 1)),
        DateFormat("yyyy-MM-dd").format(DateTime(day.year, day.month + 1, 0)));
  }

  void getMonthSchdulesData(String from, String to) async {
    monthSchedules = {};

    Map<String, dynamic> json = await getMonthSchedules(from, to);
    List<Schedule> scheduleList = [];

    if (json["status"] == "success") {
      List<dynamic> jsonList = json["data"];
      scheduleList = jsonList.map((e) {
        return Schedule.fromJson(e);
      }).toList();
    }

    for (Schedule schedule in scheduleList) {
      DateTime startDate = DateTime.parse(schedule.startDate!);
      DateTime endDate = DateTime.parse(schedule.endDate!);

      DateTime currentDate = startDate;
      while (currentDate.isBefore(endDate.add(const Duration(days: 1)))) {
        // endDate를 포함하기 위해 1일 추가
        DateTime key =
            DateTime(currentDate.year, currentDate.month, currentDate.day)
                .toUtc();

        if (monthSchedules[key] == null) {
          monthSchedules[key] = [];
        }

        monthSchedules[key]!.add(schedule);

        // 다음 날짜로 이동
        currentDate = currentDate.add(const Duration(days: 1));
      }
    }

    setState(() {});
  }

  @override
  void initState() {
    onChangeMonth(DateTime.now());

    setState(() {});

    super.initState();
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
            monthSchedules: monthSchedules,
            onChangeMonth: onChangeMonth,
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

    List<Schedule> selectedDaySchedules = monthSchedules[selectedDay] ?? [];

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          titlePadding:
              const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
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
            child: Column(
              children: [
                Expanded(
                  child: Scrollbar(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ...selectedDaySchedules.map((Schedule schedule) {
                            return GestureDetector(
                              onTap: () => {moveToDetail(schedule.scheduleId!)},
                              child: Column(
                                children: [
                                  Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 6.0),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(16.0),
                                        border: Border.all(
                                          color: Colors.black,
                                          width: 2.0,
                                        ),
                                        color: categoryType[
                                                schedule.categoryId]![1]
                                            .withOpacity(0.5)),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          categoryType[schedule.categoryId]![0],
                                          style:
                                              const TextStyle(fontSize: 20.0),
                                        ),
                                        Text(
                                          schedule.title!,
                                          style:
                                              const TextStyle(fontSize: 24.0),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 6.0,
                                  )
                                ],
                              ),
                            );
                          })
                        ],
                      ),
                    ),
                  ),
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
                                return ScheduleFormScreen(
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
