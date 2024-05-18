import 'package:client/screens/schedule/widgets/background/near_places.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:kakao_map_plugin/kakao_map_plugin.dart';

import 'styles.dart' as style;
import 'package:client/constants.dart';
import 'screens/home/home_screen.dart';
import 'screens/login/login_check_screen.dart';
import 'screens/dashboard/dashboard_screen.dart';

import 'package:client/service/member_api.dart';
import 'package:client/widgets/location_model.dart';
import 'package:client/widgets/place_search_screen.dart';
import 'screens/schedule/schedule_calendar_screen.dart';
import 'screens/schedule/schedule_detail_screen.dart';
import 'screens/gifticon/gifticon_list_screen.dart';
import 'screens/gifticon/gifticon_detail_screen.dart';
import 'screens/gifticon/gifticon_select_screen.dart';
import 'screens/profile/widgets/place/detail_place.dart';

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

  WidgetsFlutterBinding.ensureInitialized();
  await initializeService();
  // runApp(const MyApp());
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => MemberApi(),
        ),
        ChangeNotifierProvider(
          create: (context) => LocationModel(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(context) {
    return MaterialApp(
      title: 'ZZUIKSA',
      theme: style.myTheme,
      routes: {
        '/home': (context) => const HomeScreen(),
        '/dashboard': (context) => const DashboardScreen(),
        '/calendar': (context) => const CalendarScreen(),
        '/schedule/search': (context) => const SchedulePlaceSearchScreen(),
        '/schedule/detail': (context) => const ScheduleDetailScreen(),
        '/gifticon': (context) => const GifticonListScreen(),
        '/gifticon/select': (context) => const GifticonSelectScreen(),
        '/gifticon/detail': (context) => const GifticonDetailScreen(),
        '/place/detail': (context) => const PlaceDetailScreen(),
      },
      home: const LoginScreen(),
    );
  }
}
