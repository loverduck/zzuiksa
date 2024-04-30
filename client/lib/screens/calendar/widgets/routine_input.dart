import 'package:client/screens/calendar/widgets/date_time_input.dart';
import 'package:client/screens/calendar/widgets/input_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class RoutineInput extends StatefulWidget {
  const RoutineInput({
    super.key,
    required this.marginBox,
    required this.inputTitleText,
    required this.setCycle,
  });

  final SizedBox marginBox;
  final Function inputTitleText;
  final Function setCycle;

  @override
  State<RoutineInput> createState() => _RoutineInputState();
}

const Map<String, String> cycleType = {
  "DAILY": "매일",
  "WEEKLY": "매주",
  "MONTHLY": "매월",
  "YEARLY": "매년",
};

const Map<int, String> week = {
  0: "일요일",
  1: "월요일",
  2: "화요일",
  3: "수요일",
  4: "목요일",
  5: "금요일",
  6: "토요일",
};

class _RoutineInputState extends State<RoutineInput> {
  String cycle = cycleType.keys.first;
  TextEditingController routineEndController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InputContainer(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  widget.inputTitleText("반복"),
                  Container(
                    padding: const EdgeInsets.fromLTRB(16.0, 0, 0, 0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: DropdownButton(
                      value: cycle,
                      underline: Container(),
                      items: cycleType.keys
                          .map<DropdownMenuItem<String>>((String key) {
                        return DropdownMenuItem<String>(
                          value: key,
                          child: Text(
                            cycleType[key]!,
                            style: const TextStyle(
                              fontSize: 24.0,
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (val) => {
                        setState(() {
                          cycle = val!;
                        }),
                        widget.setCycle(val)
                      },
                    ),
                  ),
                ],
              ),
              const Divider(
                thickness: 1.0,
              ),
              Row(
                children: [
                  widget.inputTitleText("반복 주기"),
                  // DropdownButton(items: items, onChanged: onChanged)
                ],
              ),
              const Divider(
                thickness: 1.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  widget.inputTitleText("종료"),
                  DateTimeInput(
                    dateController: routineEndController,
                    requiredTime: false,
                  ),
                ],
              )
            ],
          ),
        ),
        widget.marginBox,
      ],
    );
  }
}
