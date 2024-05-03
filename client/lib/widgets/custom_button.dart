import 'package:flutter/material.dart';

import 'package:client/constants.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Function func;
  String? size = 'big';
  int? color = 300;

  CustomButton(
      {super.key,
        required this.text,
        required this.func,
        this.size,
        this.color});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    Color bgColor() {
      switch (color) {
        case 100: return Constants.main100;
        case 200: return Constants.main200;
        default:
          return Constants.main300;
      }
    }

    EdgeInsets edgeInsets() {
      switch (size) {
        case 'small':
          return EdgeInsets.symmetric(horizontal: 40, vertical: 10);
        case 'medium':
          return EdgeInsets.symmetric(horizontal: 80, vertical: 10);
        default:
          return EdgeInsets.symmetric(horizontal: 120, vertical: 10);
      }
    }

    return ElevatedButton(
        onPressed: () {
          func();
        },
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(bgColor()),
            side: MaterialStateProperty.all(
                BorderSide(width: 2.0, color: Constants.main600)),
            padding: MaterialStateProperty.all<EdgeInsets>(
                edgeInsets()
            )),
        child: Text(text, style: textTheme.displaySmall,
        ));
  }
}
