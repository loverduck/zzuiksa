import 'package:flutter/material.dart';

class CompleteRate extends StatefulWidget {
  const CompleteRate({super.key});
  @override
  State<CompleteRate> createState() => _CompleteRateState();
}

class _CompleteRateState extends State<CompleteRate> {
  int percent = 90;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Center(
        child: Text('$percent%', style: textTheme.displayLarge)
    );
  }
}
