import 'package:client/screens/gifticon/gifticon_add_screen.dart';
import 'package:client/screens/gifticon/gifticon_detail_screen.dart';
import 'package:client/screens/gifticon/gifticon_select_screen.dart';
import 'package:client/screens/gifticon/gifticon_update_screen.dart';
import 'package:client/screens/gifticon/model/gifticon_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'screens/calendar/calendar_screen.dart';
import 'screens/gifticon/gifticon_list_screen.dart';
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
        '/gifticon': (context) => GifticonListScreen(),
        '/gifticon_select_screen': (context) => GifticonSelectScreen(),
        '/gifticon_add_screen': (context) => GifticonAddScreen(),
        '/gifticon_detail_screen': (context) => GifticonDetailScreen(
          gifticonId: ModalRoute.of(context)!.settings.arguments as int,
        ),
        '/gifticon_update_screen': (context) => GifticonUpdateScreen(
          gifticon: ModalRoute.of(context)!.settings.arguments as Gifticon,
        ),
        '/profile': (context) => ProfileScreen(),
      },
      home: HomeScreen(),
    );
  }
}


