import 'package:client/constants.dart';
import 'package:client/screens/schedule/widgets/input_delete_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SchedulePlaceSearchScreen extends StatefulWidget {
  const SchedulePlaceSearchScreen({super.key});

  @override
  State<SchedulePlaceSearchScreen> createState() =>
      _SchedulePlaceSearchScreenState();
}

class _SchedulePlaceSearchScreenState extends State<SchedulePlaceSearchScreen> {
  TextEditingController searchEditingController = TextEditingController();

  void moveToBack() {
    Navigator.pop(context, searchEditingController.text);
  }

  @override
  Widget build(BuildContext context) {
    final keyword = ModalRoute.of(context)!.settings.arguments;

    if (keyword != null) {
      searchEditingController.text = keyword.toString();
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Constants.main200,
        leading: IconButton(
            onPressed: moveToBack, icon: const Icon(Icons.arrow_back)),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.0),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        margin: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          children: [
            const Icon(Icons.search_sharp),
            Expanded(
              child: TextField(
                controller: searchEditingController,
                textAlignVertical: TextAlignVertical.center,
                style: const TextStyle(
                  fontSize: 20.0,
                ),
                decoration: InputDecoration(
                  suffixIcon: InputDeleteIcon(
                      textEditingController: searchEditingController),
                  hintText: "지역명/장소 검색",
                  hintStyle: const TextStyle(
                    color: Colors.black54,
                    fontSize: 24.0,
                  ),
                  isDense: true,
                  filled: true,
                  fillColor: Colors.white,
                  border: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
