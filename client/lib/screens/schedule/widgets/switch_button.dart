import 'package:client/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SwitchButton extends StatefulWidget {
  const SwitchButton({
    super.key,
    required this.value,
    required this.onChanged,
  });

  final bool value;
  final void Function(bool) onChanged;

  @override
  State<SwitchButton> createState() => _SwitchButtonState();
}

class _SwitchButtonState extends State<SwitchButton> {
  @override
  Widget build(BuildContext context) {
    return Switch(
      value: widget.value,
      activeTrackColor: Constants.main400,
      inactiveThumbColor: Colors.white,
      trackOutlineWidth: MaterialStateProperty.all(0),
      onChanged: widget.onChanged,
    );
  }
}
