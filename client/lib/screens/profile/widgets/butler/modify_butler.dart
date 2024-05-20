import 'package:flutter/material.dart';

import 'package:client/constants.dart';
import 'package:client/widgets/header.dart';
import 'package:client/screens/profile/widgets/info/input_box.dart';
import 'package:client/widgets/dropdown_box.dart';

class ModifyButler extends StatefulWidget {
  const ModifyButler({super.key});

  @override
  State<ModifyButler> createState() => _ModifyButlerState();
}

class _ModifyButlerState extends State<ModifyButler> {
  var nickname = TextEditingController(); // 닉네임 입력 저장

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(80.0),
          child: Header(
            title: '집사 정보 수정',
            buttonList: [IconButton(
              icon: Icon(Icons.check),
              padding: EdgeInsets.all(32),
              iconSize: 32,
              onPressed: () {
                print('complete button clicked');
              },
            )],
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
                      // InputBox(
                      //   controller: nickname,
                      //   name: 'nickname',
                      //   placeholder: '집사 닉네임',
                      // ),
                      DropdownBox(
                        name: 'speachStyle',
                        dropdownList: ['귀여운 말투', '근엄한 말투', '딱딱한 말투'],
                      ),
                    ])),
              ),
            ],
          ),
        )));
  }
}
