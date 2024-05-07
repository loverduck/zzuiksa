import 'package:client/screens/profile/widgets/butler/my_butler.dart';
import 'package:client/widgets/header.dart';
import 'package:client/screens/profile/widgets/statistic/my_staticstic.dart';
import 'package:flutter/material.dart';

import 'widgets/menu_buttons.dart';
import 'widgets/info/my_info.dart';
import 'widgets/place/my_place.dart';

class ProfileScreen extends StatefulWidget {
  static const title = 'Profile';
  static const androidIcon = Icon(Icons.person);

  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int currentIndex = 0;

  setIndex(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(80.0),
            child: Header(
              title: '마이페이지',
              // buttonList: [
              //   IconButton(
              //     icon: Icon(Icons.room_service),
              //     padding: EdgeInsets.all(32),
              //     iconSize: 32,
              //     onPressed: () {
              //       Navigator.push(context,
              //           MaterialPageRoute(builder: (context) => MyButler()));
              //     },
              //   )
              // ],
            )),
        extendBodyBehindAppBar: true,
        body: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                    child: Column(children: [
                  Image(
                    image: AssetImage('assets/images/avatar.png'),
                    width: 120,
                    height: 120,
                  ),
                  SizedBox(height: 16),
                  Text('김싸피 님', style: textTheme.displayLarge),
                  MenuButtons(setIndex: setIndex),
                  renderBody(currentIndex),
                ])),
              ),
            ],
          ),
        )));
  }

  Widget renderBody(int index) {
    switch (index) {
      case 1:
        return MyPlace();
      case 2:
        return MyInfo();
      default:
        return MyStatistic();
    }
  }
}
