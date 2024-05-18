import 'package:client/constants.dart';
import 'package:flutter/material.dart';

class InputBox extends StatefulWidget {
  final TextEditingController controller;
  final String name;
  final String placeholder;
  final Icon? prefixIcon;

  const InputBox({
    super.key,
    required this.name,
    required this.placeholder,
    required this.controller,
    this.prefixIcon,
  });

  @override
  State<InputBox> createState() => _InputBoxState();
}

class _InputBoxState extends State<InputBox> {
  late TextEditingController controller;
  late String name;
  late String placeholder;
  late Icon? prefixIcon;
  String? errorText;
  OutlineInputBorder customBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(36),
    borderSide: const BorderSide(
      width: 3,
      color: Constants.main400,
      style: BorderStyle.solid,
    ),
  );

  bool isValidDate(String date) {
    RegExp regex = RegExp(r'^\d{4}-\d{2}-\d{2}$');
    return regex.hasMatch(date);
  }

  @override
  void initState() {
    super.initState();
    controller = widget.controller;
    name = widget.name;
    placeholder = widget.placeholder;
    prefixIcon = widget.prefixIcon;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      child: TextFormField(
        controller: controller,
        onChanged: (value) {
          if (value.isEmpty || value == '' || value.trim() == '') {
            setState(() {
              errorText = '값을 입력하세요.';
            });
          } else if (name == 'nickname' && value.length > 10) {
            setState(() {
              errorText = '닉네임은 10글자 이하여야 합니다.';
            });
          } else if (name == 'birthday' && !isValidDate(value)) {
            setState(() {
              errorText = '올바른 날짜 형식으로 입력하세요.';
            });
          } else {
            setState(() {
              errorText = null;
            });
          }
        },
        validator: (value) { // 제출 버튼이 눌렸을 때 유효성 검사 로직 실행
          if (value!.isEmpty || value == '' || value.trim() == '') {
            return '값을 입력하세요.';
          } else if (name == 'nickname' && value.length > 10) {
              return '닉네임은 10글자 이하여야 합니다.';
          } else if (name == 'birthday' && !isValidDate(value)) {
              return '올바른 날짜 형식으로 입력하세요.';
          } else {
            return null;
          }
        },
        decoration: InputDecoration(
            filled: true,
            fillColor: Constants.main100,
            contentPadding: EdgeInsets.only(left: 32, top: 16, bottom: 8),
            border: customBorder,
            enabledBorder: customBorder,
            disabledBorder: customBorder,
            focusedBorder: customBorder,
            focusedErrorBorder: customBorder,
            errorBorder: customBorder,
            labelText: placeholder,
            labelStyle: const TextStyle(color: Constants.main300, fontSize: 24),
            errorText: errorText,
            prefixIcon: prefixIcon,
            suffixIcon: IconButton(
              icon: Icon(Icons.close),
              iconSize: 32,
              color: Constants.main600,
              onPressed: () {
                controller.clear();
                setState(() {
                  errorText = '값을 입력하세요.';
                });
              },
            )),
      ),
    );
  }
}
