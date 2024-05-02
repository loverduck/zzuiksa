import 'package:client/constants.dart';
import 'package:client/screens/schedule/model/schedule_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TransportTypeButtons extends StatefulWidget {
  const TransportTypeButtons({
    super.key,
    required this.selectedType,
    required this.inputTitleText,
    required this.marginBox,
    required this.setType,
    required this.fromPlace,
  });

  final String selectedType;
  final Text inputTitleText;
  final SizedBox marginBox;
  final Function setType;
  final Place fromPlace;

  @override
  State<TransportTypeButtons> createState() => _TransportTypeButtonsState();
}

const Map<String, String> transports = {
  "PUBTRANS": "대중교통",
  "CAR": "자가용",
  "WALK": "도보",
};

class _TransportTypeButtonsState extends State<TransportTypeButtons> {
  ButtonStyle transportTypeButtonstyle = ElevatedButton.styleFrom(
    padding: const EdgeInsets.symmetric(horizontal: 32.0),
    elevation: 0,
    backgroundColor: Constants.main200.withOpacity(0.5),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
  );

  void moveToSearch() async {
    // 사용자가 검색한 위치 저장
    final place = await Navigator.pushNamed(context, "/schedule/search",
        arguments: widget.fromPlace.name);

    setState(() {
      print("출발지: ${place.toString()}");
      widget.fromPlace.name = place.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(
          thickness: 1.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            widget.inputTitleText,
            GestureDetector(
              onTap: moveToSearch,
              child: Container(
                width: 230.0,
                height: 40.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Text(
                  widget.fromPlace.name ?? "",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 24.0,
                  ),
                ),
              ),
            )
          ],
        ),
        widget.marginBox,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: transports.entries.map((item) {
            return ElevatedButton(
              style: item.key == widget.selectedType
                  ? transportTypeButtonstyle.copyWith(
                      backgroundColor:
                          const MaterialStatePropertyAll(Constants.main100),
                      side: const MaterialStatePropertyAll(BorderSide(
                        color: Constants.main400,
                        width: 3.0,
                      )),
                    )
                  : transportTypeButtonstyle,
              onPressed: () => widget.setType(item.key),
              child: Text(
                item.value,
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: item.key == widget.selectedType
                      ? FontWeight.bold
                      : FontWeight.normal,
                  color: item.key == widget.selectedType
                      ? Constants.main400
                      : Constants.main500,
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(
          height: 10.0,
        ),
        const Text(
          "예상 이동 시간: ",
          textAlign: TextAlign.left,
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.black54,
          ),
        ),
      ],
    );
  }
}
