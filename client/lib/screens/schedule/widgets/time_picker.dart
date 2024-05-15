import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimePicker extends StatefulWidget {
  const TimePicker({
    super.key,
    required this.textStyle,
    required this.timeEditController,
  });

  final TextStyle textStyle;
  final TextEditingController timeEditController;

  @override
  State<TimePicker> createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {
  void onChange() async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(
          hour: int.parse(widget.timeEditController.text.split(":")[0]),
          minute: int.parse(widget.timeEditController.text.split(":")[1])),
    );

    if (timeOfDay != null) {
      setState(() {
        widget.timeEditController.text =
            '${timeOfDay.hour.toString().padLeft(2, '0')}:${timeOfDay.minute.toString().padLeft(2, '0')}';
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
            "${widget.timeEditController.text.split(":")[0]}:${widget.timeEditController.text.split(":")[1]}",
            style: widget.textStyle,
          )),
    );
  }
}
