// Copyright 2020 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'screens/calendar/calendar_screen.dart';
import 'screens/gifticon/gifticon_screen.dart';
import 'screens/profile/profile_screen.dart';
import 'screens/home/songs_screen.dart';

void main() => runApp(const MyAdaptingApp());

class MyAdaptingApp extends StatelessWidget {
  const MyAdaptingApp({super.key});

  @override
  Widget build(context) {
    return MaterialApp(
      title: 'ZZUIKSA',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      darkTheme: ThemeData.dark(),
      builder: (context, child) {
        return CupertinoTheme(
          data: const CupertinoThemeData(),
          child: Material(child: child),
        );
      },
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() =>
      _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int current_index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: current_index,
        children: [
          SongsScreen(),
          CalendarScreen(),
          GifticonScreen(),
          ProfileScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        //현재 index 변수에 저장
        currentIndex: current_index,
        //tap -> index 변경
        onTap: (index) {
          print('index test : ${index}');
          setState(() {
            current_index = index;
          });
        },
        //BottomNavi item list
        items: const [
          BottomNavigationBarItem(
            icon: SongsScreen.androidIcon,
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: CalendarScreen.androidIcon,
            label: 'Calendar',
          ),
          BottomNavigationBarItem(
            icon: GifticonScreen.androidIcon,
            label: 'Gifticon',
          ),
          BottomNavigationBarItem(
            icon: ProfileScreen.androidIcon,
            label: 'Profile',
          ),
        ],
        //selected된 item color
        selectedItemColor: Colors.red,
        //unselected된 item color
        unselectedItemColor: Colors.grey,
        showSelectedLabels: false,
        //unselected된 label text
        showUnselectedLabels: false,
        iconSize: 36.0,
        //BottomNavigationBar Type -> fixed = bottom item size고정
        //BottomNavigationBar Type -> shifting = bottom item selected 된 item이 확대
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}