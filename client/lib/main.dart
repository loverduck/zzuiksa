
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'screens/calendar/calendar_screen.dart';
import 'screens/gifticon/gifticon_screen.dart';
import 'screens/profile/profile_screen.dart';
import 'screens/dashboard/songs_screen.dart';
import 'screens/home/home_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(context) {
    return MaterialApp(
      title: 'ZZUIKSA',
      theme: ThemeData(),
      darkTheme: ThemeData.dark(),
      routes: {
        '/dashboard': (context) => SongsScreen(),
        '/calendar': (context) => CalendarScreen(),
        '/gifticon': (context) => GifticonScreen(),
        '/profile': (context) => ProfileScreen(),
      },
      home: HomeScreen(),
    );
  }
}


