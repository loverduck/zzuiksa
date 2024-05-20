import 'package:flutter/cupertino.dart';

class SnackBarText extends StatefulWidget {
  const SnackBarText({super.key, required this.message});
  final String message;

  @override
  State<SnackBarText> createState() => _SnackBarTextState();
}

class _SnackBarTextState extends State<SnackBarText> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.message,
      style: const TextStyle(
        fontSize: 24.0,
      ),
    );
  }
}
