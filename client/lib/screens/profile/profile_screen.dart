import 'package:client/screens/profile/widgets/my_staticstic.dart';
import 'package:flutter/material.dart';

import 'widgets/buttons/menu_buttons.dart';
import 'widgets/my_info.dart';
import 'widgets/my_place.dart';

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
          child: AppBar(
            backgroundColor: Colors.transparent,
            title: Text('마이페이지', style: textTheme.displayLarge),
            centerTitle: true,
            toolbarHeight: 80.0,
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.settings),
                iconSize: 32.0,
                padding: EdgeInsets.all(24),
                onPressed: () {
                  print('Search button is clicked');
                },
              ),
            ],
          ),
        ),
        extendBodyBehindAppBar: true,
        body: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(20.0),
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
      case 1: return MyInfo();
      case 2: return Container(height: 400, child: MyPlace());
      default: return MyStatistic();
    }
  }
}
