import 'package:client/styles.dart';
import 'package:flutter/material.dart';

import '../../../../constants.dart';

class GifticonStoreMapButton extends StatelessWidget {
  final VoidCallback onPressed;

  const GifticonStoreMapButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Constants.green300,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
          side: const BorderSide(
            color: Color(0xFF5E3136),
            width: 2.5,
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      ),
      child: Text('지도로 보기', style: myTheme.textTheme.displaySmall,),
    );
  }
}
