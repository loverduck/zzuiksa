import 'package:flutter/material.dart';

import 'package:client/constants.dart';

class BackupButton extends StatelessWidget {
  static const _confirmMessage = Text("정말 탈퇴하시겠어요?");
  const BackupButton({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return ElevatedButton(
        onPressed: () {
          print('backup button clicked');
        },
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Constants.main300),
            side: MaterialStateProperty.all(
                BorderSide(width: 2.0, color: Constants.main600)),
            padding: MaterialStateProperty.all<EdgeInsets>(
              EdgeInsets.symmetric(horizontal: 40, vertical: 10),
            )),
        child: Text(
          '기록 백업하기',
          style: textTheme.displaySmall,
        ));
  }
}
