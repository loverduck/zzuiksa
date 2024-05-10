import 'package:client/constants.dart';
import 'package:flutter/material.dart';

class InputBox extends StatelessWidget {
  final TextEditingController controller;
  final String name;
  final String placeholder;
  final IconButton? prefixIcon;
  final IconButton? suffixIcon;

  const InputBox({
    super.key,
    required this.name,
    required this.placeholder,
    required this.controller,
    this.prefixIcon,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
            filled: true,
            fillColor: Constants.main100,
            contentPadding: EdgeInsets.only(left: 32, top: 16, bottom: 8),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                width: 3,
                color: Constants.main400,
                style: BorderStyle.solid,
              ),
              borderRadius: BorderRadius.circular(36),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                width: 3,
                color: Constants.main500,
                style: BorderStyle.solid,
              ),
              borderRadius: BorderRadius.circular(36),
            ),
            labelText: placeholder,
            labelStyle: const TextStyle(color: Constants.main300, fontSize: 24),
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon),
      ),
    );
  }
}
