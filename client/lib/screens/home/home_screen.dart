import 'package:client/screens/dashboard/songs_screen.dart';
import 'package:client/screens/calendar/calendar_screen.dart';
import 'package:client/screens/gifticon/gifticon_screen.dart';
import 'package:client/screens/profile/profile_screen.dart';

import 'package:flutter/material.dart';
import 'package:client/widgets/footer.dart';

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
        return CalendarScreen();
      case 2:
        return GifticonScreen();
      case 3:
        return ProfileScreen();
      default:
        return SongsScreen();
    }
  }
}
