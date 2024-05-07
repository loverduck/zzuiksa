import 'package:client/screens/schedule/model/schedule_model.dart';
import 'package:client/screens/schedule/utils/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:client/constants.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatefulWidget {
  final DateTime foucsedDay;
  final OnDaySelected onDaySelected;
  final bool Function(DateTime day) selectedDayPredicate;

  const Calendar({
    super.key,
    required this.foucsedDay,
    required this.onDaySelected,
    required this.selectedDayPredicate,
  });

  @override
  State<Calendar> createState() => _CalendarState();
}

Map<int, Color> categoryColor = {
  0: Constants.green300,
  1: Constants.blue300,
  2: Constants.pink300,
  3: Constants.violet300,
};

class _CalendarState extends State<Calendar> {
  Map<DateTime, List<Schedule>> groupSchedules = {};

  @override
  void initState() {
    getGroupSchedules();
    super.initState();
  }

  void getGroupSchedules() {
    groupSchedules = {};

    for (Schedule schedule in schedulesData) {
      DateTime date = DateTime.parse(schedule.startDate!);
      DateTime key = DateTime(date.year, date.month, date.day).toUtc();

      if (groupSchedules[key] == null) {
        groupSchedules[key] = [];
      }

      groupSchedules[key]!.add(schedule);
    }
  }

  @override
  Widget build(BuildContext context) {
    Container defaultContainer(
        {required DateTime day,
        Color? color = Constants.textColor,
        BoxDecoration? boxDecoration}) {
      return Container(
        padding: const EdgeInsets.all(4),
        alignment: Alignment.topCenter,
        decoration: boxDecoration,
        child: Text(
          day.day.toString(),
          style: TextStyle(
            color: color,
          ),
        ),
      );
    }

    const double containerBorderRadius = 16;

    return TableCalendar(
      locale: "ko_KR",
      shouldFillViewport: true,
      firstDay: DateTime(1800),
      focusedDay: widget.foucsedDay,
      lastDay: DateTime(2400),
      daysOfWeekHeight: 30,
      eventLoader: (day) {
        return groupSchedules[day] ?? [];
      },
      headerStyle: const HeaderStyle(
        leftChevronVisible: false,
        rightChevronVisible: false,
        formatButtonVisible: false,
        headerPadding: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 0),
        titleTextStyle: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
        ),
      ),
      onDaySelected: widget.onDaySelected,
      // selectedDayPredicate: selectedDayPredicate,
      calendarBuilders: CalendarBuilders(
        // 이벤트 표시
        markerBuilder: (context, date, groupSchedules) {
          if (groupSchedules.isNotEmpty) {
            return Container(
              padding: const EdgeInsets.fromLTRB(2.0, 0, 2.0, 0),
              child: buildEventMarker(date, groupSchedules),
            );
          }
          return null;
        },
        // 일반 날짜
        defaultBuilder: (context, day, foucsedDay) {
          // 1일이고 일요일(화면의 첫 번째 날짜일 때 왼쪽 위 보더 둥글게)
          if (day.day == 1 && day.weekday == 7) {
            return defaultContainer(
              day: day,
              color: Colors.red[200],
              boxDecoration: BoxDecoration(
                color: Colors.white.withOpacity(0.7),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(containerBorderRadius),
                ),
              ),
            );
          }

          // 화면의 첫 번째 토요일일 때 오른쪽 위 보더 둥글게
          if (day.day <= 7 && day.weekday == 6) {
            return defaultContainer(
              day: day,
              boxDecoration: BoxDecoration(
                color: Colors.white.withOpacity(0.7),
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(containerBorderRadius),
                ),
              ),
            );
          }

          // 화면의 마지막 일요일일 때 왼쪽 아래 둥글게
          if (day.day >= 24 && day.weekday == 7) {
            return defaultContainer(
              day: day,
              color: Colors.red,
              boxDecoration: BoxDecoration(
                color: Colors.white.withOpacity(0.7),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(containerBorderRadius),
                ),
              ),
            );
          }

          return defaultContainer(
              day: day,
              color: day.weekday == DateTime.sunday ? Colors.red : Colors.black,
              boxDecoration: BoxDecoration(
                color: Colors.white.withOpacity(0.7),
              ));
        },

        // 이전 달, 다음 달 날짜
        outsideBuilder: (context, day, foucsedDay) {
          // 일요일(화면의 첫 번째 날짜면 왼쪽 위 보더 둥글게)
          if (day.weekday == 7) {
            return defaultContainer(
              day: day,
              color: Colors.red[200],
              boxDecoration: BoxDecoration(
                color: Colors.white.withOpacity(0.7),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(containerBorderRadius),
                ),
              ),
            );
          }

          // 토요일(화면의 마지막 날짜면 오른쪽 아래 보더 둥글게)
          if (day.weekday == 6) {
            return defaultContainer(
              day: day,
              color: Colors.black38,
              boxDecoration: BoxDecoration(
                color: Colors.white.withOpacity(0.7),
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(containerBorderRadius),
                ),
              ),
            );
          }

          return defaultContainer(
              day: day,
              color: day.weekday == DateTime.sunday
                  ? Colors.red[200]
                  : Colors.black38,
              boxDecoration: BoxDecoration(
                color: Colors.white.withOpacity(0.7),
              ));
        },
        // 공휴일 -> 적용 되는지 확인 필요
        holidayBuilder: (context, day, focusedDay) {
          return defaultContainer(
            day: day,
            color: Colors.red,
            boxDecoration: BoxDecoration(
              color: Colors.white.withOpacity(0.7),
            ),
          );
        },
        todayBuilder: ((context, day, focusedDay) {
          return Container(
            padding: const EdgeInsets.all(4),
            alignment: Alignment.topCenter,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.7),
            ),
            child: Transform.translate(
              offset: const Offset(0, -2),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Constants.main600,
                ),
                alignment: Alignment.center,
                width: 24,
                height: 24,
                child: Text(
                  focusedDay.day.toString(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

// 이벤트 마커 커스텀
Widget buildEventMarker(DateTime date, List events) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(0, 30.0, 0, 8.0),
    child: Column(
      children: [
        ...events.take(3).map(
              (e) => Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(4.0, 0, 4.0, 0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.0),
                      color: categoryColor[e.categoryId]!.withOpacity(0.7),
                    ),
                    child: Text(
                      "${e.title}",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14.0,
                        decoration: e.isDone
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 3.0,
                  ),
                ],
              ),
            ),
        if (events.length > 3)
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 4.0),
                child: Text(
                  "+${events.length - 3}",
                  style: const TextStyle(
                    color: Colors.black45,
                    fontSize: 10.0,
                  ),
                ),
              ),
            ],
          )
      ],
    ),
  );
}
