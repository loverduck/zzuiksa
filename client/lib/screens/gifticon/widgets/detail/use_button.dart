import 'package:client/styles.dart';
import 'package:flutter/material.dart';

import '../../../../constants.dart';

class UseButton extends StatelessWidget {
  final VoidCallback onPressed;

  const UseButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Constants.main400,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(35),
          side: const BorderSide(
            color: Color(0xFF5E3136),
            width: 2.5,
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        minimumSize: Size(250, 25),
      ),
      child: Text('사용하기', style: myTheme.textTheme.displayMedium,),
    );
  }
}
