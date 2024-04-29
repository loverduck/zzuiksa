import 'package:client/screens/calendar/calendar_place_search_screen.dart';
import 'package:client/screens/calendar/widgets/date_time_input.dart';
import 'package:client/screens/calendar/widgets/input_container.dart';
import 'package:client/screens/calendar/widgets/input_delete_icon.dart';
import 'package:client/screens/calendar/widgets/switch_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:client/constants.dart';

class CalendarAddScreen extends StatefulWidget {
  const CalendarAddScreen({
    super.key,
    required this.selectedDay,
  });

  final DateTime selectedDay;

  @override
  State<CalendarAddScreen> createState() => _CalendarAddScreenState();
}

class _CalendarAddScreenState extends State<CalendarAddScreen> {
  TextEditingController titleEditConteroller = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  bool isAllDay = false;
  bool isRoutine = false;

  @override
  void initState() {
    super.initState();
    startDateController.text = widget.selectedDay.toString().split(" ")[0];
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
    Map<String, Color> categoryColor = <String, Color>{
      "일정": Constants.green300,
      "업무": Constants.blue600,
    };

    String selectedCategory = categoryColor.keys.first;

    TextField titleInputField = TextField(
      controller: titleEditConteroller,
      decoration: InputDecoration(
        hintText: "제목",
        hintStyle: const TextStyle(
          color: Constants.main500,
        ),
        suffixIcon:
            InputDeleteIcon(textEditingController: titleEditConteroller),
        border: InputBorder.none,
        isDense: true,
      ),
      style: const TextStyle(
        fontSize: 20,
      ),
    );

    DropdownButton categoryDropdown = DropdownButton(
      value: selectedCategory,
      onChanged: (value) {
        print(value);
      },
      selectedItemBuilder: (context) {
        return categoryColor.values.map<Widget>((Color color) {
          return Container(
            padding: const EdgeInsets.symmetric(vertical: 6.0),
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: color,
            ),
          );
        }).toList();
      },
      items: categoryColor.keys.map<DropdownMenuItem<String>>((String item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Row(
            children: [
              Container(
                width: 18,
                height: 18,
                decoration: BoxDecoration(
                  color: categoryColor[item],
                ),
              ),
              const SizedBox(
                width: 6,
              ),
              Text(
                item,
                style: const TextStyle(
                  fontSize: 18,
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

    void moveToSearch() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return const CalendarPlaceSearchScreen();
          },
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Constants.main200,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Text("저장"),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
                    Flexible(
                      child: categoryDropdown,
                    ),
                  ],
                ),
              ),
            ),
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
            if (!isAllDay)
              Expanded(
                child: Column(
                  children: [
                    InputContainer(
                      child: Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            inputTitleText("시작"),
                            DateTimeInput(
                              dateController: startDateController,
                            )
                          ],
                        ),
                      ),
                    ),
                    InputContainer(
                      child: Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            inputTitleText("종료"),
                            DateTimeInput(
                              dateController: startDateController,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            // 장소 입력
            InputContainer(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  inputTitleText("장소"),
                  GestureDetector(
                    onTap: moveToSearch,
                    child: Container(
                      width: 230.0,
                      constraints: const BoxConstraints(
                        minHeight: 40.0,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: const Text(""),
                    ),
                  ),
                ],
              ),
            ),
            // 알림
            InputContainer(
              child: Row(
                children: [
                  inputTitleText("알림"),
                ],
              ),
            ),
            InputContainer(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                inputTitleText("반복"),
                SwitchButton(
                  value: isRoutine,
                  onChanged: (val) {
                    setState(() {
                      isRoutine = val;
                    });
                  },
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
