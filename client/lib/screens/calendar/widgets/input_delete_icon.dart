import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InputDeleteIcon extends StatefulWidget {
  const InputDeleteIcon({
    super.key,
    required this.textEditingController,
  });

  final TextEditingController textEditingController;

  @override
  State<InputDeleteIcon> createState() => _InputDeleteIconState();
}

class _InputDeleteIconState extends State<InputDeleteIcon> {
  @override
  Widget build(BuildContext context) {
    return widget.textEditingController.text.isNotEmpty
        ? IconButton(
            onPressed: () {
              print("delete");
              widget.textEditingController.clear();
            },
            icon: const Icon(
              Icons.cancel,
              color: Colors.black87,
              size: 24.0,
            ),
          )
        : const Icon(
            Icons.cancel,
            color: Colors.black38,
            size: 24.0,
          );
  }
}
