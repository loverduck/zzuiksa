import 'package:app_settings/app_settings.dart';
import 'package:client/screens/dashboard/dashboard_screen.dart';
import 'package:client/screens/gifticon/gifticon_list_screen.dart';
import 'package:client/screens/profile/profile_screen.dart';
import 'package:client/screens/schedule/schedule_calendar_screen.dart';
import 'package:client/widgets/location_model.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:client/widgets/footer.dart';
import 'package:client/service/member_api.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int bottomIndex = 0;

  setBottomIndex(int index) {
    setState(() {
      bottomIndex = index;
    });
  }

  Future<void> checkLocationService(BuildContext context) async {
    Map<String, dynamic> res = await checkLocationPermission();

    if (res["status"] != "granted") {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("위치 권한 설정 필요"),
            content: const Text("사용자의 위치를 필요로 합니다. 설정에서 권한을 변경해주세요."),
            actions: <Widget>[
              TextButton(
                child: const Text("OK"),
                onPressed: () {
                  AppSettings.openAppSettings();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      checkLocationService(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: renderBody(bottomIndex),
      bottomNavigationBar: Footer(setBottomIndex: setBottomIndex),
    );
  }

  Widget renderBody(int index) {
    switch (index) {
      case 1:
        return const CalendarScreen();
      case 2:
        return const GifticonListScreen();
      case 3:
        // return ProfileScreen(member);
        return Consumer<MemberApi>(
          builder: (context, memberProvider, child) {
            return memberProvider.member != null
                ? ProfileScreen(memberProvider.member)
                : Container();
          },
        );
      default:
        return const DashboardScreen();
    }
  }
}
