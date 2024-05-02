import 'package:flutter/material.dart';

import 'package:client/constants.dart';

class SpotInitializeButton extends StatelessWidget {
  const SpotInitializeButton({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return TextButton(
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Constants.main300),
          side: MaterialStateProperty.all(
              BorderSide(width: 2.0, color: Constants.main600)),
          padding: MaterialStateProperty.all<EdgeInsets>(
            EdgeInsets.symmetric(horizontal: 64, vertical: 10),
          )),
      child: Text(
        '현재 위치로 초기화하기',
        style: textTheme.displaySmall,
      ),
      onPressed: () => Navigator.pop(context),
    );
  }
}
