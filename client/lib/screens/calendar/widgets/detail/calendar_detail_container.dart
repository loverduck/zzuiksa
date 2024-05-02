import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CalendarDetailContainer extends StatefulWidget {
  const CalendarDetailContainer({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  State<CalendarDetailContainer> createState() =>
      _CalendarDetailContainerState();
}

class _CalendarDetailContainerState extends State<CalendarDetailContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(
          color: Colors.black,
          width: 2.0,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: widget.child,
      ),
    );
  }
}
