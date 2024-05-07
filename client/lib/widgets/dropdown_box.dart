import 'package:client/constants.dart';
import 'package:flutter/material.dart';

class DropdownBox extends StatefulWidget {
  final String name;
  final List<String> dropdownList;

  const DropdownBox({
    super.key,
    required this.name,
    required this.dropdownList,
  });

  @override
  State<DropdownBox> createState() => _DropdownBoxState();
}

class _DropdownBoxState extends State<DropdownBox> {
  var _list = ['아이템이 없습니다.'];
  String? _selected;

  @override
  void initState() {
    super.initState();
    _list = widget.dropdownList; // Assign dropdownList to _list
    setState(() {
      _selected = _list[0];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        child: DropdownButtonFormField(
          decoration: InputDecoration(
            filled: true,
            fillColor: Constants.main100,
            contentPadding: EdgeInsets.only(left: 32, top: 24, bottom: 8),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                width: 3,
                color: Constants.main500,
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
            labelStyle: const TextStyle(color: Constants.main300, fontSize: 24),
          ),
          dropdownColor: Constants.main100,

          itemHeight: 64,
          icon: const Padding(
              padding: EdgeInsets.only(right:16), child: Icon(Icons.arrow_drop_down)),
          style: const TextStyle(
              color: Constants.textColor, fontSize: 32, fontFamily: 'OwnglyphChongchong'),
          value: _selected,
          items: _list
              .map((e) => DropdownMenuItem(
                    value: e,
                    child: Text(e),
                  ))
              .toList(),
          onChanged: (value) {
            setState(() {
              _selected = value!;
            });
          },
        ));
  }
}
