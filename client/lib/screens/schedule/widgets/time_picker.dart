import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TimePicker extends StatefulWidget {
  const TimePicker({super.key, required this.textStyle});

  final TextStyle textStyle;

  @override
  State<TimePicker> createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {
  TimeOfDay initialTime = TimeOfDay(hour: TimeOfDay.now().hour + 1, minute: 0);

  void onChange() async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );

    if (timeOfDay != null) {
      setState(() {
        initialTime = timeOfDay;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      width: 80.0,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: GestureDetector(
          onTap: onChange,
          child: Text(
            textAlign: TextAlign.center,
            "${initialTime.hour}:${initialTime.minute}",
            style: widget.textStyle,
          )),
    );
  }
}
