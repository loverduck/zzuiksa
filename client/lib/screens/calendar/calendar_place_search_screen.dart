import 'package:client/constants.dart';
import 'package:client/screens/calendar/widgets/input_delete_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CalendarPlaceSearchScreen extends StatefulWidget {
  const CalendarPlaceSearchScreen({super.key});

  @override
  State<CalendarPlaceSearchScreen> createState() =>
      _CalendarPlaceSearchScreenState();
}

class _CalendarPlaceSearchScreenState extends State<CalendarPlaceSearchScreen> {
  TextEditingController searchEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Constants.main200,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            TextField(
              controller: searchEditingController,
              decoration: InputDecoration(
                prefixIcon: const Icon(
                  Icons.search_sharp,
                  color: Colors.black54,
                ),
                suffix: InputDeleteIcon(
                    textEditingController: searchEditingController),
                hintText: "지역명/장소 검색",
                hintStyle: const TextStyle(
                  color: Colors.black54,
                  fontSize: 20.0,
                ),
                isDense: true,
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.0),
                  borderSide: BorderSide.none,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
