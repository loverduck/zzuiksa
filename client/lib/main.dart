import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'screens/calendar/calendar_screen.dart';
import 'screens/gifticon/gifticon_screen.dart';
import 'screens/profile/profile_screen.dart';
import 'screens/dashboard/dashboard_screen.dart';
import 'screens/home/home_screen.dart';
import 'styles.dart' as style;

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(context) {
    return MaterialApp(
      title: 'ZZUIKSA',
      theme: style.myTheme,
      routes: {
        '/dashboard': (context) => DashboardScreen(),
        '/calendar': (context) => CalendarScreen(),
        '/gifticon': (context) => GifticonScreen(),
        '/profile': (context) => ProfileScreen(),
      },
      home: HomeScreen(),
    );
  }
}


