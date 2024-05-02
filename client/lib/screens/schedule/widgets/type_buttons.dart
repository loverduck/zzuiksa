import 'package:client/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TypeButtons extends StatefulWidget {
  const TypeButtons({
    super.key,
    required this.selectedType,
    required this.inputTitleText,
    required this.marginBox,
    required this.setType,
  });

  final String selectedType;
  final Text inputTitleText;
  final SizedBox marginBox;
  final Function setType;

  @override
  State<TypeButtons> createState() => _TypeButtonsState();
}

const Map<String, String> transports = {
  "PUBTRANS": "대중교통",
  "CAR": "자가용",
  "WALK": "도보",
};

class _TypeButtonsState extends State<TypeButtons> {
  ButtonStyle typeButtonStyle = ElevatedButton.styleFrom(
    padding: const EdgeInsets.symmetric(horizontal: 32.0),
    elevation: 0,
    backgroundColor: Constants.main200.withOpacity(0.5),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
  );

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
            Container(
              width: 230.0,
              height: 40.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.0),
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
                  ? typeButtonStyle.copyWith(
                      backgroundColor:
                          const MaterialStatePropertyAll(Constants.main100),
                      side: const MaterialStatePropertyAll(BorderSide(
                        color: Constants.main400,
                        width: 3.0,
                      )),
                    )
                  : typeButtonStyle,
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
