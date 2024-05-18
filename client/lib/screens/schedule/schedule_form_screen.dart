import 'package:client/screens/schedule/service/schedule_api.dart';
import 'package:client/screens/schedule/model/schedule_model.dart';
import 'package:client/screens/schedule/widgets/date_time_input.dart';
import 'package:client/screens/schedule/widgets/input_container.dart';
import 'package:client/screens/schedule/widgets/routine_input.dart';
import 'package:client/screens/schedule/widgets/switch_button.dart';
import 'package:client/screens/schedule/widgets/place_input.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:client/constants.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class ScheduleFormScreen extends StatefulWidget {
  const ScheduleFormScreen({
    super.key,
    required this.selectedDay,
    this.schedule,
  });

  final DateTime selectedDay;
  final Schedule? schedule;

  @override
  State<ScheduleFormScreen> createState() => _ScheduleFormScreenState();
}

class _ScheduleFormScreenState extends State<ScheduleFormScreen> {
  TextEditingController titleEditConteroller = TextEditingController();
  TextEditingController startDateEditController = TextEditingController();
  TextEditingController endDateEditController = TextEditingController();
  TextEditingController startTimeEditController = TextEditingController();
  TextEditingController endTimeEditController = TextEditingController();
  TextEditingController placeEditController = TextEditingController();
  TextEditingController alertEditController = TextEditingController();
  TextEditingController memoEditController = TextEditingController();

  bool isAllDay = false;
  bool isRepeat = false;
  bool isDone = false;
  bool isValid = false;

  int selectedCategory = 1;
  Place? toPlace = Place();
  Place? fromPlace = Place();
  String selectedType = "TRANSIT";
  Repeat? _repeat;

  String? errorMsg;

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // 기본 시작/종료 날짜 = 선택한 날짜
    // 기본 시작/종료 시간 = 현재 시간 + 1 / + 2
    titleEditConteroller.text = widget.schedule?.title ?? "";
    startDateEditController.text = widget.schedule?.startDate ??
        widget.selectedDay.toString().split(" ")[0];
    endDateEditController.text =
        widget.schedule?.endDate ?? widget.selectedDay.toString().split(" ")[0];
    startTimeEditController.text = widget.schedule?.startTime ??
        "${DateFormat("H").format(DateTime.now())}:00";
    endTimeEditController.text = widget.schedule?.endTime ??
        "${DateFormat("H").format(DateTime.now().add(const Duration(hours: 1)))}:00";

    selectedCategory = widget.schedule?.categoryId ?? 1;
    alertEditController.text = widget.schedule?.alertBefore.toString() ?? "";
    memoEditController.text = widget.schedule?.memo ?? "";
    toPlace!.name = widget.schedule?.toPlace?.name;
    placeEditController.text = widget.schedule?.toPlace?.name ?? "";
    fromPlace!.name = widget.schedule?.fromPlace?.name;
    _repeat = widget.schedule?.repeat;
    isDone = widget.schedule?.isDone ?? false;

    titleEditConteroller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    titleEditConteroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextField titleInputField = TextField(
      onChanged: (title) => {
        if (titleEditConteroller.text.isEmpty)
          {
            {
              setState(() {
                isValid = false;
              })
            }
          }
        else
          {isValid = true}
      },
      controller: titleEditConteroller,
      decoration: const InputDecoration(
        hintText: "제목",
        hintStyle: TextStyle(
          fontSize: 24.0,
          color: Constants.main500,
        ),
        border: InputBorder.none,
        isDense: true,
      ),
      style: const TextStyle(
        fontSize: 24.0,
      ),
    );

    DropdownButton categoryDropdown = DropdownButton(
      isExpanded: true,
      value: selectedCategory,
      onChanged: (value) {
        setState(() {
          selectedCategory = value;
        });
      },
      underline: Container(),
      selectedItemBuilder: (context) {
        return categoryType.values.map<Widget>((List item) {
          return Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 9.25, horizontal: 6.0),
            child: Container(
              constraints: const BoxConstraints(maxHeight: 15.0),
              decoration: BoxDecoration(
                color: item[1],
              ),
            ),
          );
        }).toList();
      },
      items: categoryType.keys.map<DropdownMenuItem<int>>((int id) {
        return DropdownMenuItem<int>(
          value: id,
          child: Row(
            children: [
              Container(
                width: 18,
                height: 18,
                decoration: BoxDecoration(
                  color: categoryType[id]?[1],
                ),
              ),
              const SizedBox(
                width: 6,
              ),
              Text(
                categoryType[id]?[0],
                style: const TextStyle(
                  fontSize: 18.0,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );

    Text inputTitleText(String title) {
      return Text(
        title,
        style: const TextStyle(fontSize: 24.0),
      );
    }

    SizedBox marginBox = const SizedBox(
      height: 12.0,
    );

    void toggleAllDay(val) {
      setState(() {
        isAllDay = val;

        if (!val) {
          startTimeEditController.text =
              "${DateFormat("H").format(DateTime.now())}:00";
          endTimeEditController.text =
              "${DateFormat("H").format(DateTime.now().add(const Duration(hours: 1)))}:00";
        } else {
          startTimeEditController.text = "";
          endTimeEditController.text = "";
        }
      });
    }

    void setPlace(String type, Place place) {
      if (type == "from") {
        setState(() {
          fromPlace = place;
        });
      } else {
        setState(() {
          toPlace = place;
        });
      }
    }

    void setType(type) {
      setState(() {
        selectedType = type.toString();
      });
    }

    void setRepeat(repeat) {
      setState(() {
        _repeat = repeat;
      });
    }

    void createSchedule() async {
      if (startDateEditController.text.isNotEmpty &&
          endTimeEditController.text.isNotEmpty) {
        DateTime startDateTime = DateTime.parse(
            "${startDateEditController.text} ${startTimeEditController.text}");
        DateTime endDateTime = DateTime.parse(
            "${endDateEditController.text} ${endTimeEditController.text}");

        if (startDateTime.isAfter(endDateTime)) {
          setState(() {
            errorMsg = "종료 시간이 시작 시간보다 빠를 수 없습니다.";
          });
          return;
        } else {
          setState(() {
            errorMsg = null;
          });
        }
      }

      Schedule schedule = Schedule(
        categoryId: selectedCategory,
        title: titleEditConteroller.text,
        startDate: startDateEditController.text,
        endDate: endDateEditController.text,
        startTime: startTimeEditController.text.isEmpty
            ? null
            : "${startTimeEditController.text}:00",
        endTime: endTimeEditController.text.isEmpty
            ? null
            : "${endTimeEditController.text}:00",
        alertBefore: alertEditController.text.isEmpty
            ? null
            : int.parse(alertEditController.text),
        memo: memoEditController.text,
        toPlace:
            (toPlace!.name == null || toPlace!.name!.isEmpty) ? null : toPlace,
        fromPlace: (fromPlace!.name == null || fromPlace!.name!.isEmpty)
            ? null
            : fromPlace,
        repeat: _repeat,
        isDone: false,
      );

      Map<String, dynamic> res = await postSchedule(schedule);

      if (res["status"] == "success") {
        Navigator.pop(context);
      } else {
        setState(() {
          errorMsg = "잠시 후 다시 시도해주세요.";
        });
      }
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Constants.main200,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: GestureDetector(
              onTap: () => {
                if (isValid) {createSchedule()}
              },
              child: Text(
                "저장",
                style: TextStyle(
                  fontSize: 24.0,
                  color: isValid ? Colors.black : Colors.black45,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                if (errorMsg != null) ...[
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 10.0),
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.3),
                      border: Border.all(
                        color: Colors.red,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Text(
                      errorMsg!,
                      style: TextStyle(
                        fontSize: 24.0,
                        color: Colors.red[900],
                      ),
                    ),
                  ),
                  marginBox,
                ],
                // 제목
                InputContainer(
                  child: SizedBox(
                    child: Row(
                      children: [
                        Flexible(
                          flex: 4,
                          child: titleInputField,
                        ),
                        const SizedBox(
                          width: 16.0,
                        ),
                        Expanded(
                          // flex: 1,
                          child: categoryDropdown,
                        ),
                      ],
                    ),
                  ),
                ),
                marginBox,
                // 종일 여부
                InputContainer(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      inputTitleText("종일"),
                      SwitchButton(
                        value: isAllDay,
                        onChanged: toggleAllDay,
                      ),
                    ],
                  ),
                ),
                // 종일이 아닐 경우 날짜 및 시간 선택
                marginBox,
                Column(
                  children: [
                    InputContainer(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          inputTitleText("시작"),
                          DateTimeInput(
                            dateController: startDateEditController,
                            requiredTime: !isAllDay,
                            timeEditController: startTimeEditController,
                          )
                        ],
                      ),
                    ),
                    marginBox,
                    InputContainer(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          inputTitleText("종료"),
                          DateTimeInput(
                            dateController: endDateEditController,
                            requiredTime: !isAllDay,
                            timeEditController: endTimeEditController,
                          )
                        ],
                      ),
                    ),
                    marginBox,
                  ],
                ),
                // 장소 입력
                PlaceInput(
                    selectedType: selectedType,
                    inputTitleText: inputTitleText,
                    marginBox: marginBox,
                    setType: setType,
                    setPlace: setPlace),
                marginBox,
                // 알림
                InputContainer(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      inputTitleText("알림"),
                      Row(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            width: 80.0,
                            constraints: const BoxConstraints(
                              minHeight: 40.0,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12.0),
                              child: TextField(
                                keyboardType: TextInputType.number,
                                controller: alertEditController,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  isDense: true,
                                ),
                                style: const TextStyle(
                                    fontSize: 24.0, height: 1.0),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10.0,
                          ),
                          const Text(
                            "분 전",
                            style: TextStyle(fontSize: 24.0),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                marginBox,

                // 반복 여부
                InputContainer(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      inputTitleText("반복"),
                      SwitchButton(
                        value: isRepeat,
                        onChanged: (val) {
                          setState(() {
                            isRepeat = val;

                            if (val) {
                              _repeat = Repeat();
                            } else {
                              _repeat = null;
                            }
                          });
                        },
                      ),
                    ],
                  ),
                ),
                marginBox,
                if (isRepeat)
                  RoutineInput(
                    inputTitleText: inputTitleText,
                    marginBox: marginBox,
                    setRepeat: setRepeat,
                  ),
                // 메모
                InputContainer(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      inputTitleText("메모"),
                      const Divider(
                        thickness: 1.0,
                      ),
                      SizedBox(
                        height: 200.0,
                        child: TextField(
                          controller: memoEditController,
                          style: const TextStyle(
                            fontSize: 24.0,
                          ),
                          expands: true,
                          maxLines: null,
                          decoration: const InputDecoration(
                            isDense: true,
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 16.0,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
