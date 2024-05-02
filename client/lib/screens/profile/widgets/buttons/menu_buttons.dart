import 'package:flutter/material.dart';

import 'package:client/constants.dart';
import '../../utils/highlight_text.dart';

class MenuButtons extends StatefulWidget {
  const MenuButtons({Key? key, required this.setIndex}) : super(key: key);
  final Function setIndex;

  @override
  State<MenuButtons> createState() => _MenuButtonsState();
}

class _MenuButtonsState extends State<MenuButtons> {
  @override
  Widget build(BuildContext context) {
    int selectedIndex = 0;
    final textTheme = Theme.of(context).textTheme;

    return Container(
        margin: EdgeInsets.all(16),
        padding: EdgeInsets.only(top: 2, bottom: 2, left: 8, right: 8),
        decoration: BoxDecoration(
          border: Border.all(color: Constants.main600, width: 2),
          borderRadius: BorderRadius.circular(30),
          color: Constants.main100,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextButton(
                onPressed: () {
                  setState(() {
                    selectedIndex = 0;
                    widget.setIndex(selectedIndex);
                  });
                },
                child: MyStatisticText(isHighlighted: selectedIndex == 0)),
            TextButton(
                onPressed: () {
                  setState(() {
                    selectedIndex = 1;
                    widget.setIndex(selectedIndex);
                  });
                },
                child: MyInfoText(isHighlighted: selectedIndex == 1)),
            TextButton(
                onPressed: () {
                  setState(() {
                    selectedIndex = 2;
                    widget.setIndex(selectedIndex);
                  });
                },
                child: MyPlaceText(isHighlighted: selectedIndex == 2)),
          ],
        ));
  }
}

class MyStatisticText extends StatelessWidget {
  const MyStatisticText({Key? key, required this.isHighlighted})
      : super(key: key);
  final bool isHighlighted;

  @override
  Widget build(BuildContext context) {
    if (isHighlighted) {
      return HighLightedText('달성 통계', color: Constants.main400);
    } else {
      return Text('달성 통계',
          style: TextStyle(fontSize: 22, color: Constants.textColor));
    }
  }
}

class MyInfoText extends StatelessWidget {
  const MyInfoText({Key? key, required this.isHighlighted}) : super(key: key);
  final isHighlighted;

  @override
  Widget build(BuildContext context) {
    if (isHighlighted) {
      return HighLightedText('내 정보', color: Constants.main400);
    } else {
      return Text('내 정보',
          style: TextStyle(fontSize: 22, color: Constants.textColor));
    }
  }
}

class MyPlaceText extends StatelessWidget {
  const MyPlaceText({Key? key, required this.isHighlighted}) : super(key: key);
  final isHighlighted;

  @override
  Widget build(BuildContext context) {
    if (isHighlighted) {
      return HighLightedText('내 주소', color: Constants.main400);
    } else {
      return Text('내 주소',
          style: TextStyle(fontSize: 22, color: Constants.textColor));
    }
  }
}
