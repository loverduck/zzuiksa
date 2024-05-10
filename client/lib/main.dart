import 'package:client/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:kakao_map_plugin/kakao_map_plugin.dart';

import 'screens/dashboard/dashboard_screen.dart';
import 'screens/schedule/schedule_calendar_screen.dart';
import 'screens/schedule/schedule_detail_screen.dart';
import 'screens/schedule/schedule_place_search_screen.dart';
import 'screens/profile/profile_screen.dart';
import 'screens/gifticon/gifticon_list_screen.dart';
import 'screens/gifticon/gifticon_add_screen.dart';
import 'screens/gifticon/gifticon_detail_screen.dart';
import 'screens/gifticon/gifticon_select_screen.dart';
import 'screens/gifticon/gifticon_update_screen.dart';
import 'screens/gifticon/model/gifticon_model.dart';
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

  AuthRepository.initialize(
      appKey: dotenv.get("KAKAO_JAVASCRIPT_KEY"), baseUrl: baseUrl);

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
        '/schedule/search': (context) => const SchedulePlaceSearchScreen(),
        '/schedule/detail': (context) => const ScheduleDetailScreen(),
        '/gifticon': (context) => const GifticonListScreen(),
        '/gifticon_select_screen': (context) => const GifticonSelectScreen(),
        '/gifticon_add_screen': (context) => const GifticonAddScreen(),
        '/gifticon_detail_screen': (context) => GifticonDetailScreen(
              gifticonId: ModalRoute.of(context)!.settings.arguments as int,
            ),
        '/gifticon_update_screen': (context) => GifticonUpdateScreen(
              gifticon: ModalRoute.of(context)!.settings.arguments as Gifticon,
            ),
        '/profile': (context) => const ProfileScreen(),
      },
      home: const HomeScreen(),
    );
  }
}
