import 'package:flutter/material.dart';

import 'package:client/constants.dart';

class SpotPickButton extends StatelessWidget {
  const SpotPickButton({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return TextButton(
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Constants.main300),
          side: MaterialStateProperty.all(
              BorderSide(width: 2.0, color: Constants.main600)),
          padding: MaterialStateProperty.all<EdgeInsets>(
            EdgeInsets.symmetric(horizontal: 80, vertical: 10),
          )),
      child: Text('이 장소를 선택하기', style: textTheme.displaySmall,),
      onPressed: () => Navigator.pop(context),
    );
  }
}
