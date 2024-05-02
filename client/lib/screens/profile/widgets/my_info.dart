import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'buttons/modify_button.dart';
import 'buttons/withdrawal_button.dart';
import 'package:client/constants.dart';

class MyInfo extends StatelessWidget {
  static const title = 'Profile';
  static const androidIcon = Icon(Icons.person);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Table(
            columnWidths: {
              0: FixedColumnWidth(80.0),
              1: FixedColumnWidth(160.0),
            },
            children: [
              TableRow(children: [
                Text('닉네임',
                    style: TextStyle(color: Constants.main400, fontSize: 22),
                    textAlign: TextAlign.center),
                Text('김싸피',
                    style: textTheme.displaySmall, textAlign: TextAlign.center)
              ]),
              TableRow(children: [
                Text('카카오 ID',
                    style: TextStyle(color: Constants.main400, fontSize: 22),
                    textAlign: TextAlign.center),
                Text('kim@ssafy.com',
                    style: textTheme.displaySmall, textAlign: TextAlign.center)
              ]),
              TableRow(children: [
                Text('생일',
                    style: TextStyle(color: Constants.main400, fontSize: 22),
                    textAlign: TextAlign.center),
                Text('2000년 1월 1일',
                    style: textTheme.displaySmall, textAlign: TextAlign.center)
              ]),
            ],
          ),
          SizedBox(height: 20),
          const ModifyButton(),
          SizedBox(height: 8),
          const WithdrawalButton(),
        ],
      ),
    );
  }
}
