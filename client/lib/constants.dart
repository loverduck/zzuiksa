import 'package:flutter/material.dart';

class Constants {
  //Colors
  static const main600 = Color(0xFF795458);
  static const main500 = Color(0xFFC08B5C);
  static const main400 = Color(0xFFED9455);
  static const main300 = Color(0xFFFFBB70);
  static const main200 = Color(0xFFFFEC9E);
  static const main100 = Color(0xFFFFFBDA);
  static const blue600 = Color(0xFF453F78);
  static const blue300 = Color(0xFF9BB8CD);
  static const green300 = Color(0xFFB1C381);
  static const pink400 = Color(0xFFFF6666);
  static const pink300 = Color(0xFFFF8989);
  static const pink200 = Color(0xFFFCAEAE);
  static const violet300 = Color(0xFFD89ADF);
  static const textColor = Color(0xFF451E1E);
}

String baseUrl = "https://k10a202.p.ssafy.io";

Map<int, List> categoryType = <int, List>{
  1: ["일정", Constants.green300],
  2: ["업무", Constants.blue300],
  3: ["기념일", Constants.pink300],
  4: ["공부", Constants.violet300],
};

const Map<String, String> cycleType = {
  "DAILY": "매일",
  "WEEKLY": "매주",
  "MONTHLY": "매월",
  "YEARLY": "매년",
};

const Map<int, String> week = {
  1: "월요일",
  2: "화요일",
  3: "수요일",
  4: "목요일",
  5: "금요일",
  6: "토요일",
  7: "일요일",
};
