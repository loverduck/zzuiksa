import 'package:client/screens/schedule/widgets/time_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DateTimeInput extends StatefulWidget {
  const DateTimeInput({
    super.key,
    required this.dateController,
    required this.requiredTime,
    this.timeEditController,
    this.onChange,
  });

  final TextEditingController dateController;
  final bool requiredTime;
  final TextEditingController? timeEditController;
  final Function? onChange;

  @override
  State<DateTimeInput> createState() => _DateTimeInputState();
}

class _DateTimeInputState extends State<DateTimeInput> {
  Future<void> selectDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2400),
    );

    if (pickedDate != null) {
      setState(() {
        widget.dateController.text = pickedDate.toString().split(" ")[0];
        if (widget.onChange != null) {
          widget.onChange!(pickedDate.toString().split(" ")[0]);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 140,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.0),
          ),
          padding: const EdgeInsets.only(bottom: 4.0),
          child: TextField(
            textAlign: TextAlign.center,
            decoration: const InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.zero,
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
              ),
            ),
            style: const TextStyle(
              fontSize: 24.0,
            ),
            controller: widget.dateController,
            readOnly: true,
            onTap: () {
              selectDate();
            },
          ),
        ),
        if (widget.requiredTime) ...[
          const SizedBox(
            width: 10.0,
          ),
          TimePicker(
            textStyle: const TextStyle(fontSize: 24.0),
            timeEditController: widget.timeEditController!,
          ),
        ]
      ],
    );
  }
}
