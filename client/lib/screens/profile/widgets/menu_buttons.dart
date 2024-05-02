import 'package:flutter/material.dart';

import 'package:client/constants.dart';
import '../utils/highlight_text.dart';

class MenuButtons extends StatefulWidget {
  const MenuButtons({Key? key, required this.setIndex}) : super(key: key);
  final Function setIndex;

  @override
  State<MenuButtons> createState() => _MenuButtonsState();
}

class _MenuButtonsState extends State<MenuButtons> {
  Text myStatistic =
      Text('달성 통계', style: TextStyle(fontSize: 22, color: Constants.textColor));
  Text myInfo =
      Text('내 정보', style: TextStyle(fontSize: 22, color: Constants.textColor));
  Text myPlace =
      Text('내 주소', style: TextStyle(fontSize: 22, color: Constants.textColor));
  HighLightedText htStatistic =
      HighLightedText('달성 통계', color: Constants.main400);
  HighLightedText htInfo = HighLightedText('내 정보', color: Constants.main400);
  HighLightedText htPlace = HighLightedText('내 주소', color: Constants.main400);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    int selectedIndex = 0;

    Widget _statisticText = selectedIndex == 0 ? htStatistic : myStatistic;
    Widget _infoText = selectedIndex == 1 ? htInfo : myInfo;
    Widget _placeText = selectedIndex == 2 ? htPlace : myPlace;

    return Container(
        height: 60,
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
                child: _statisticText),
            TextButton(
                onPressed: () {
                  setState(() {
                    selectedIndex = 1;
                    widget.setIndex(selectedIndex);
                  });
                },
                child: _infoText),
            TextButton(
                onPressed: () {
                  setState(() {
                    selectedIndex = 2;
                    widget.setIndex(selectedIndex);
                  });
                },
                child: _placeText),
          ],
        ));
  }
}
