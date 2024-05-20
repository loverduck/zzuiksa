import 'package:client/screens/schedule/model/schedule_model.dart';
import 'package:client/screens/schedule/schedule_detail_screen.dart';
import 'package:client/screens/schedule/schedule_form_screen.dart';
import 'package:client/screens/schedule/service/schedule_api.dart';
import 'package:client/screens/schedule/utils/local_time_convertor.dart';
import 'package:client/screens/schedule/widgets/loading_dialog.dart';
import 'package:client/screens/schedule/widgets/snackbar_text.dart';
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
  DateTime focusedDay = DateTime.now();
  Map<DateTime, List<Schedule>> monthSchedules = {};
  late List<Schedule> selectedDaySchedules;
  TextEditingController scheduleSentenceEditController =
      TextEditingController();

  void moveToDetail(int scheduleId) {
    Navigator.pop(context);
    Navigator.pushNamed(context, '/schedule/detail',
            arguments: {"scheduleId": scheduleId})
        .then((value) => onChangeMonth(DateTime.now()));
  }

  void onPressedAddButton(selectedDay) async {
    if (scheduleSentenceEditController.text.isEmpty) {
      Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return ScheduleFormScreen(
              selectedDay: selectedDay,
            );
          },
        ),
      ).then((value) => onChangeMonth(selectedDay));
    } else {
      // + 버튼 클릭 시 키보드 내리기
      FocusManager.instance.primaryFocus?.unfocus();

      Map<String, dynamic> body = {
        "categoryId": 1,
        "content": scheduleSentenceEditController.text,
        "baseDate": DateFormat("yyyy-MM-dd").format(selectedDay),
      };

      try {
        LoadingDialog.showDialog(context);

        Map<String, dynamic> res = await postRecognize(body);

        if (!mounted) return;

        if (res["status"] == "success") {
          Navigator.pop(context);
          scheduleSentenceEditController.text = "";
          onChangeMonth(DateTime.now());
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: SnackBarText(message: "일정을 생성할 수 없습니다. 잠시 후 다시 시도해주세요."),
          ),
        );
      } finally {
        Navigator.pop(context);
      }
    }
  }

  void onChangeMonth(DateTime day) {
    getMonthSchdulesData(
        DateFormat("yyyy-MM-dd").format(DateTime(day.year, day.month, 1)),
        DateFormat("yyyy-MM-dd").format(DateTime(day.year, day.month + 1, 0)));

    setState(() {
      focusedDay = DateTime(DateTime.now().year, day.month, DateTime.now().day);
    });
  }

  void getMonthSchdulesData(String from, String to) async {
    monthSchedules = {};

    Future.delayed(Duration.zero, () {
      LoadingDialog.showDialog(context);
    });

    if (!mounted) return;

    try {
      Map<String, dynamic> json = await getMonthSchedules(from, to);
      List<Schedule> scheduleList = [];

      if (json["status"] == "success") {
        List<dynamic> jsonList = json["data"];
        scheduleList = jsonList.map((e) {
          return Schedule.fromJson(e);
        }).toList();

        for (Schedule schedule in scheduleList) {
          DateTime startDate = DateTime.parse(schedule.startDate!);
          DateTime endDate = DateTime.parse(schedule.endDate!);

          DateTime currentDate = startDate;
          while (currentDate.isBefore(endDate.add(const Duration(days: 1)))) {
            // endDate를 포함하기 위해 1일 추가
            DateTime key = localTimeConvertor(currentDate);

            if (monthSchedules[key] == null) {
              monthSchedules[key] = [];
            }

            monthSchedules[key]!.add(schedule);

            // 다음 날짜로 이동
            currentDate = currentDate.add(const Duration(days: 1));
          }
        }
      }
      setState(() {});
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: SnackBarText(message: "일정을 불러올 수 없습니다. 종료 후 다시 접속해주세요."),
        ),
      );
    } finally {
      Navigator.pop(context);
    }
  }

  @override
  void didChangeDependencies() {
    onChangeMonth(DateTime.now());
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 8),
          child: Calendar(
            foucsedDay: focusedDay,
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
    selectedDay = localTimeConvertor(selectedDay);
    setState(() {
      this.selectedDay = selectedDay;
    });

    selectedDaySchedules = monthSchedules[selectedDay] ?? [];

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          titlePadding:
              const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
          contentPadding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0),
          backgroundColor: Constants.main200,
          shape: RoundedRectangleBorder(
            side: const BorderSide(
              color: Colors.black,
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text(
            DateFormat("MM월 dd일(E)", "ko_KR").format(selectedDay),
            style: const TextStyle(
              fontSize: 28.0,
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
                              onTap: () => moveToDetail(schedule.scheduleId!),
                              child: ScheduleContainer(
                                schedule: schedule,
                                monthSchedules: monthSchedules,
                                selectedDay: selectedDay,
                              ),
                            );
                          })
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            child: Stack(
                              alignment: Alignment.centerRight,
                              children: [
                                TextField(
                                  controller: scheduleSentenceEditController,
                                  decoration: const InputDecoration(
                                    contentPadding:
                                        EdgeInsets.fromLTRB(12.0, 0, 60.0, 0),
                                    hintText: "일정을 입력해주세요",
                                    hintStyle: TextStyle(
                                      color: Colors.black54,
                                      fontSize: fontSizeSmall,
                                    ),
                                    border: InputBorder.none,
                                  ),
                                  style: const TextStyle(
                                    fontSize: fontSizeSmall,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Transform.translate(
                      offset: const Offset(8, 0),
                      child: IconButton(
                        onPressed: () => onPressedAddButton(selectedDay),
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
    ).then((value) => scheduleSentenceEditController.text = "");
  }

  bool selectedDayPredicate(DateTime date) {
    if (selectedDay == null) {
      return false;
    }

    return date.isAtSameMomentAs(selectedDay!);
  }
}

class ScheduleContainer extends StatefulWidget {
  const ScheduleContainer(
      {super.key,
      required this.schedule,
      required this.monthSchedules,
      required this.selectedDay});
  final Schedule schedule;
  final Map<DateTime, List> monthSchedules;
  final DateTime selectedDay;

  @override
  State<ScheduleContainer> createState() => _ScheduleContainerState();
}

class _ScheduleContainerState extends State<ScheduleContainer> {
  @override
  Widget build(BuildContext context) {
    void toggleIsDone(int scheduleId) async {
      late Schedule schedule;
      Map<String, dynamic> res = await getSchedule(scheduleId);

      if (res['status'] == 'success') {
        setState(() {
          schedule = Schedule.fromJson(res['data']);
          schedule.scheduleId = scheduleId;
          schedule.isDone = !schedule.isDone!;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: SnackBarText(
              message: "로딩에 실패했습니다. 잠시 후 다시 시도해주세요",
            ),
          ),
        );
      }

      try {
        res = await patchSchedule(schedule);

        if (res['status'] == 'success') {
          setState(() {
            widget.schedule.isDone = schedule.isDone;
            widget.monthSchedules[widget.selectedDay]!
                .indexWhere((s) => s.scheduleId == schedule.scheduleId);
          });
        } else {
          throw Error();
        }
      } catch (e) {
        print("patch error: $e");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: SnackBarText(
              message: "연결에 실패했습니다. 잠시 후 다시 시도해주세요",
            ),
          ),
        );
      }
    }

    return Column(
      children: [
        AnimatedOpacity(
          duration: const Duration(milliseconds: 300),
          opacity: widget.schedule.isDone! ? 0.7 : 1.0,
          child: Container(
            width: double.infinity,
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              border: Border.all(
                color: Colors.black,
                width: 1.0,
              ),
              color:
                  categoryType[widget.schedule.categoryId]![1].withOpacity(0.5),
            ),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => toggleIsDone(widget.schedule.scheduleId!),
                  child: Container(
                    width: 28.0,
                    height: 28.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        width: 1.0,
                      ),
                    ),
                    child: widget.schedule.isDone!
                        ? const Icon(Icons.check)
                        : Container(),
                  ),
                ),
                const SizedBox(
                  width: 10.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      categoryType[widget.schedule.categoryId]![0],
                      style: const TextStyle(
                        fontSize: 18.0,
                        height: 1.0,
                        color: Colors.black54,
                      ),
                    ),
                    Text(
                      widget.schedule.title!,
                      style: const TextStyle(
                        fontSize: 24.0,
                        height: 1.0,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 8.0,
        )
      ],
    );
  }
}
