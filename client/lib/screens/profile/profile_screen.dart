import 'package:flutter/material.dart';
import 'package:client/styles.dart';
import 'package:client/constants.dart';
import 'package:client/widgets/header.dart';
import 'model/member_model.dart';

import 'widgets/butler/my_butler.dart';
import 'widgets/statistic/my_staticstic.dart';
import 'widgets/place/my_place.dart';
import 'widgets/info/my_info.dart';


class ProfileScreen extends StatelessWidget {
  static const title = 'Profile';
  static const androidIcon = Icon(Icons.person);

  final Member member;
  const ProfileScreen(this.member, {super.key});

  @override
  Widget build(context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(80.0),
          child: Header(
            title: '마이페이지',
            buttonList: [
              IconButton(
                icon: Icon(Icons.room_service),
                padding: EdgeInsets.all(32),
                iconSize: 32,
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MyButler()));
                },
              )
            ],
          )),
      // extendBodyBehindAppBar: true,
      body: SafeArea(
          child: SingleChildScrollView(
              child: Column(children: [
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
            Text('${member.name} 님', style: textTheme.displayLarge),
            DefaultTabController(
              length: 3,
              child: Column(children: [
                TabBar(
                  padding: EdgeInsets.all(20),
                  indicatorColor: Constants.main400,
                  labelColor: Constants.main400,
                  labelStyle: myTheme.textTheme.displaySmall,
                  unselectedLabelColor: Constants.textColor,
                  unselectedLabelStyle: myTheme.textTheme.displaySmall,
                  dividerColor: Colors.transparent,
                  tabs: [
                    Tab(text: '내 정보'),
                    Tab(text: '내 장소'),
                    Tab(text: '달성 통계'),
                  ],
                ),
                Container(
                    height: 800,
                    child: TabBarView(children: [
                      MyInfo(member),
                      MyPlace(),
                      MyStatistic(),
                    ]))
              ]),
            )
          ])),
        )
      ]))),
    );
  }
}
