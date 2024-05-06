import 'package:client/screens/profile/widgets/butler/my_butler.dart';
import 'package:flutter/material.dart';

import 'package:client/constants.dart';

class ButlerButton extends StatelessWidget {
  const ButlerButton({super.key});

  @override
  Widget build(context) {
    return IconButton(
      icon: Icon(Icons.settings),
      iconSize: 32.0,
      padding: EdgeInsets.all(24),
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MyButler()));
      },
    );
  }
}
