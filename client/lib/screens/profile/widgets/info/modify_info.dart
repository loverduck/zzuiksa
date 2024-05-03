import 'package:flutter/material.dart';

import 'package:client/constants.dart';
import '../input_box.dart';

class ModifyInfo extends StatefulWidget {
  const ModifyInfo({super.key});

  @override
  State<ModifyInfo> createState() => _ModifyInfoState();
}

class _ModifyInfoState extends State<ModifyInfo> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(80.0),
          child: AppBar(
            backgroundColor: Colors.transparent,
            title: Text('내 정보 수정', style: textTheme.displayLarge),
            centerTitle: true,
            toolbarHeight: 80.0,
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.check),
                iconSize: 32.0,
                padding: EdgeInsets.all(24),
                onPressed: () {
                  print('setting button clicked');
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
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              InputBox(name: 'address2', placeholder: '나머지 주소를 입력하세요'),
                              InputBox(name: 'name', placeholder: '장소명을 입력하세요'),
                              InputBox(name: 'category', placeholder: '분류를 선택하세요'),
                            ])),
                  ),
                ],
              ),
            )));
  }
}
