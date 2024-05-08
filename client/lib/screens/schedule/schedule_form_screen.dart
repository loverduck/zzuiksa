import 'package:client/screens/schedule/service/schedule_api.dart';
import 'package:client/screens/schedule/model/schedule_model.dart';
import 'package:client/screens/schedule/widgets/date_time_input.dart';
import 'package:client/screens/schedule/widgets/input_container.dart';
import 'package:client/screens/schedule/widgets/routine_input.dart';
import 'package:client/screens/schedule/widgets/switch_button.dart';
import 'package:client/screens/schedule/widgets/transport_type_buttons.dart';
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
  Place toPlace = Place(name: "");
  Place fromPlace = Place(name: "");
  String selectedType = "";
  String selectedCycle = "";

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
        "${DateFormat("H").format(DateTime.now().add(const Duration(hours: 10)))}:00";
    endTimeEditController.text = widget.schedule?.endTime ??
        "${DateFormat("H").format(DateTime.now().add(const Duration(hours: 11)))}:00";

    selectedCategory = widget.schedule?.categoryId ?? 1;
    alertEditController.text = widget.schedule?.alertBefore.toString() ?? "";
    memoEditController.text = widget.schedule?.memo ?? "";
    toPlace.name = widget.schedule?.toPlace?.name ?? "";
    placeEditController.text = widget.schedule?.toPlace?.name ?? "";
    fromPlace.name = widget.schedule?.fromPlace?.name ?? "";
    isRepeat = widget.schedule?.repeat ?? false;
    isDone = widget.schedule?.isDone ?? false;

    if (widget.schedule != null) {
      print(widget.schedule);
      print(placeEditController.text);
    }

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
    Map<int, List> categoryType = <int, List>{
      1: ["일정", Constants.green300],
      2: ["업무", Constants.blue600],
      3: ["기념일", Constants.pink300],
    };

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
        fontSize: 20.0,
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

    void moveToSearch() async {
      // 사용자가 검색한 위치 저장
      final place = await Navigator.pushNamed(context, "/schedule/search",
          arguments: toPlace.name);

      setState(() {
        toPlace.name = place.toString();
      });
    }

    void setType(type) {
      setState(() {
        selectedType = type.toString();
      });
    }

    void setCycle(cycle) {
      setState(() {
        selectedCycle = cycle;
      });
    }

    void createSchedule() {
      Schedule schedule = Schedule(
        categoryId: selectedCategory,
        title: titleEditConteroller.text,
        startDate: startDateEditController.text,
        endDate: endDateEditController.text,
        startTime: startTimeEditController.text,
        endTime: endTimeEditController.text,
        alertBefore: 0,
        memo: memoEditController.text,
        toPlace: toPlace,
        fromPlace: fromPlace,
        repeat: isRepeat,
        isDone: false,
      );

      // postSchedule(schedule);
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
                        onChanged: (val) {
                          setState(() {
                            isAllDay = val;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                // 종일이 아닐 경우 날짜 및 시간 선택
                marginBox,
                Column(
                  children: [
                    InputContainer(
                      child: Expanded(
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
                    ),
                    marginBox,
                    InputContainer(
                      child: Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            inputTitleText("종료"),
                            DateTimeInput(
                              dateController: startDateEditController,
                              requiredTime: !isAllDay,
                              timeEditController: endTimeEditController,
                            )
                          ],
                        ),
                      ),
                    ),
                    marginBox,
                  ],
                ),
                // 장소 입력
                InputContainer(
                  child: Column(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        inputTitleText("장소"),
                        GestureDetector(
                          onTap: moveToSearch,
                          child: Container(
                            alignment: Alignment.center,
                            width: 230.0,
                            height: 40.0,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            child: Text(
                              toPlace.name ?? "",
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 24.0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    // 도착지가 있는 경우 출발지 선택 및 이동 방법 선택
                    if (toPlace.name!.isNotEmpty)
                      TransportTypeButtons(
                        inputTitleText: inputTitleText("출발지"),
                        selectedType: selectedType,
                        marginBox: marginBox,
                        setType: setType,
                        fromPlace: fromPlace,
                      ),
                  ]),
                ),
                marginBox,
                // 알림
                // 장소가 있는 경우에만 입력 가능
                if (placeEditController.text.isNotEmpty) ...[
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
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0),
                                child: TextField(
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    isDense: true,
                                  ),
                                  style: const TextStyle(
                                      fontSize: 20.0, height: 1.0),
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
                ],

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

                            // 종일이면
                            if (val) {
                              startTimeEditController.text = "00:00";
                              endTimeEditController.text = "23:59";
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
                    setCycle: setCycle,
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
                            fontSize: 20.0,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
