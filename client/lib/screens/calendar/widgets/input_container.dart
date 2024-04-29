import 'package:client/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InputContainer extends StatelessWidget {
  final Widget child;

  const InputContainer({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        minHeight: 100,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: Constants.main100,
        border: Border.all(
          color: Colors.black,
          width: 2.0,
        ),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: child,
    );
  }
}
