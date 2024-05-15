import 'dart:async';

import 'package:client/constants.dart';
import 'package:client/screens/schedule/model/schedule_model.dart';
import 'package:client/screens/schedule/widgets/date_time_input.dart';
import 'package:client/screens/schedule/widgets/input_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class RoutineInput extends StatefulWidget {
  const RoutineInput({
    super.key,
    required this.marginBox,
    required this.inputTitleText,
    required this.setRepeat,
  });

  final SizedBox marginBox;
  final Function inputTitleText;
  final Function setRepeat;

  @override
  State<RoutineInput> createState() => _RoutineInputState();
}

class _RoutineInputState extends State<RoutineInput> {
  String cycle = cycleType.keys.first;
  TextEditingController routineEndController = TextEditingController();
  TextEditingController dailyRepeatEditingController =
      TextEditingController(text: "1");
  Repeat repeat = Repeat(cycle: "DAILY");
  Timer? inputTimer;
  int weeklyRepeat = 2;
  int repeatDay = 1;
  int monthlyRepeat = 1;
  List<String> yearlyRepeat =
      DateFormat("MM-dd").format(DateTime.now()).split("-");

  final SizedBox _boxMargin = const SizedBox(
    width: 12.0,
  );

  void setTerm(int term) {
    repeat.repeatAt = term;
    widget.setRepeat(repeat);
  }

  void setEndDate(String date) {
    repeat.endDate = date;
    widget.setRepeat(repeat);
  }

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
                      value: repeat.cycle,
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
                      onChanged: (cycle) => {
                        setState(() {
                          switch (cycle) {
                            case "DAILY":
                              repeat.repeatAt = int.parse(
                                  dailyRepeatEditingController.text.isEmpty
                                      ? "1"
                                      : dailyRepeatEditingController.text);
                              break;
                            case "WEEKLY":
                              repeat.repeatAt = weeklyRepeat;
                              break;
                            case "MONTHLY":
                              repeat.repeatAt = monthlyRepeat;
                              break;
                            case "YEARLY":
                              repeat.repeatAt = int.parse(
                                  "${yearlyRepeat[0]}${yearlyRepeat[1]}");
                            default:
                          }
                          repeat.cycle = cycle;
                        }),
                        widget.setRepeat(repeat)
                      },
                    ),
                  ),
                ],
              ),
              const Divider(
                thickness: 1.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  widget.inputTitleText("반복 주기"),
                  switch (repeat.cycle) {
                    "DAILY" => Row(
                        children: [
                          _InputContainer(
                            width: 56.0,
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: TextField(
                              keyboardType: TextInputType.number,
                              controller: dailyRepeatEditingController,
                              onChanged: (val) => {
                                if (val.isNotEmpty) {setTerm(int.parse(val))}
                              },
                              decoration: const InputDecoration(
                                isDense: true,
                                contentPadding:
                                    EdgeInsets.fromLTRB(0, 2.0, 0, 10.0),
                                border: InputBorder.none,
                                fillColor: Colors.white,
                              ),
                              style: const TextStyle(
                                fontSize: 24.0,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          _boxMargin,
                          const Text(
                            "일마다",
                            style: TextStyle(
                              fontSize: 24.0,
                            ),
                          ),
                        ],
                      ),
                    "WEEKLY" => Row(
                        children: [
                          _InputContainer(
                            child: DropdownButton(
                              value: week[repeatDay],
                              onChanged: (val) {
                                setState(() {
                                  weeklyRepeat = 0;
                                  for (var item in week.keys) {
                                    if (week[item] == val) {
                                      repeatDay = item;
                                      weeklyRepeat |= 1 << item;
                                      setTerm(weeklyRepeat);
                                      break;
                                    }
                                  }
                                });
                              },
                              underline: Container(),
                              items: week.values
                                  .map<DropdownMenuItem<String>>((String key) {
                                return DropdownMenuItem<String>(
                                  value: key,
                                  child: Text(
                                    key,
                                    style: const TextStyle(fontSize: 24.0),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                          _boxMargin,
                          const Text(
                            "마다",
                            style: TextStyle(fontSize: 24.0),
                          ),
                        ],
                      ),
                    "MONTHLY" => Row(
                        children: [
                          _InputContainer(
                            child: DropdownButton<int>(
                              value: monthlyRepeat,
                              underline: Container(),
                              onChanged: (val) {
                                setState(() {
                                  monthlyRepeat = val!;
                                  setTerm(monthlyRepeat);
                                });
                              },
                              items: List<DropdownMenuItem<int>>.generate(
                                31,
                                (index) => DropdownMenuItem(
                                  value: index + 1,
                                  child: Text(
                                    "${index + 1}",
                                    style: const TextStyle(fontSize: 24.0),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          _boxMargin,
                          const Text("일 마다",
                              style: TextStyle(
                                fontSize: 24.0,
                              ))
                        ],
                      ),
                    "YEARLY" => Row(
                        children: [
                          _InputContainer(
                            child: DropdownButton<int>(
                              value: int.parse(yearlyRepeat[0]),
                              underline: Container(),
                              onChanged: (val) {
                                setState(() {
                                  yearlyRepeat[0] = val.toString();
                                  setTerm(int.parse(
                                      "${yearlyRepeat[0]}${yearlyRepeat[1]}"));
                                });
                              },
                              items: List<DropdownMenuItem<int>>.generate(
                                12,
                                (index) => DropdownMenuItem(
                                  value: index + 1,
                                  child: Text(
                                    "${index + 1}",
                                    style: const TextStyle(fontSize: 24.0),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          _boxMargin,
                          const Text(
                            "월",
                            style: TextStyle(fontSize: 24.0),
                          ),
                          _boxMargin,
                          _InputContainer(
                            child: DropdownButton<int>(
                              value: int.parse(yearlyRepeat[1]),
                              underline: Container(),
                              onChanged: (val) {
                                setState(() {
                                  yearlyRepeat[1] = val.toString();
                                  setTerm(int.parse(
                                      "${yearlyRepeat[0]}${yearlyRepeat[1]}"));
                                });
                              },
                              items: List<DropdownMenuItem<int>>.generate(
                                31,
                                (index) => DropdownMenuItem(
                                  value: index + 1,
                                  child: Text(
                                    "${index + 1}",
                                    style: const TextStyle(fontSize: 24.0),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          _boxMargin,
                          const Text(
                            "일 마다",
                            style: TextStyle(fontSize: 24.0),
                          ),
                        ],
                      ),
                    _ => const Text("기타"),
                  }
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
                    onChange: setEndDate,
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

class _InputContainer extends StatefulWidget {
  const _InputContainer(
      {this.width,
      required this.child,
      this.padding = const EdgeInsets.fromLTRB(16.0, 0, 0, 0)});

  final double? width;
  final Widget child;
  final EdgeInsets padding;

  @override
  State<_InputContainer> createState() => __InputContainerState();
}

class __InputContainerState extends State<_InputContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: widget.padding,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
      ),
      width: widget.width,
      child: widget.child,
    );
  }
}
