import 'package:client/screens/calendar/calendar_place_search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

import 'screens/calendar/calendar_screen.dart';
import 'screens/gifticon/gifticon_screen.dart';
import 'screens/profile/profile_screen.dart';
import 'screens/dashboard/dashboard_screen.dart';
import 'screens/home/home_screen.dart';
import 'styles.dart' as style;

// void main() => runApp(const MyApp());

void main() async {
  await dotenv.load(fileName: 'local.env');
  await initializeDateFormatting();

  WidgetsFlutterBinding.ensureInitialized();

  // runApp() 호출 전 Flutter SDK 초기화
  KakaoSdk.init(
    nativeAppKey: dotenv.get("KAKAO_NATIVE_APP_KEY"),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(context) {
    return MaterialApp(
      title: 'ZZUIKSA',
      theme: style.myTheme,
      routes: {
        '/dashboard': (context) => const DashboardScreen(),
        '/calendar': (context) => const CalendarScreen(),
        '/calendar/search': (context) => const CalendarPlaceSearchScreen(),
        '/gifticon': (context) => const GifticonScreen(),
        '/profile': (context) => const ProfileScreen(),
      },
      home: const HomeScreen(),
    );
  }
}
