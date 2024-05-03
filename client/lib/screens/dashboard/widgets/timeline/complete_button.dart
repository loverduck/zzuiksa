import 'package:flutter/material.dart';

import 'package:client/constants.dart';

class CompleteButton extends StatelessWidget {
  const CompleteButton({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return ElevatedButton(
        onPressed: () {
          print('complete button clicked');
        },
        style: ButtonStyle(
            fixedSize: MaterialStatePropertyAll(Size(80,14)),
            backgroundColor: MaterialStateProperty.all(Constants.main100),
          side: MaterialStateProperty.all(
                BorderSide(width: 2.0, color: Constants.main600)),
            ),
        child: Text('완료!', style: textTheme.displaySmall,
        ));
  }
}
