import 'package:client/screens/dashboard/dashboard_screen.dart';
import 'package:client/screens/gifticon/gifticon_list_screen.dart';
import 'package:client/screens/profile/profile_screen.dart';
import 'package:client/screens/schedule/schedule_calendar_screen.dart';

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
