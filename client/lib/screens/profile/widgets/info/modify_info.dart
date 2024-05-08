import 'package:client/screens/profile/profile_screen.dart';
import 'package:flutter/material.dart';

import 'package:client/constants.dart';
import 'package:client/widgets/header.dart';
import 'package:client/widgets/input_box.dart';
import 'package:client/widgets/custom_button.dart';

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
          child: Header(title:'내 정보 수정',
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
                    child: Column(children: <Widget>[
                  IconButton(
                    onPressed: () {},
                    icon: Image.asset(
                      'assets/images/avatar.png',
                      width: 120,
                      height: 120,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(18),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CustomButton(
                            text: '사진 바꾸기',
                            size: 'small',
                            func: () {
                              print('image modify button clicked');
                            },
                          ),
                          CustomButton(
                            text: '사진 초기화',
                            size: 'small',
                            color: 200,
                            func: () {
                              print('image initialize button clicked');
                            },
                          ),
                        ]),
                  ),
                  InputBox(
                    name: 'nickname',
                    placeholder: '닉네임',
                    prefixIcon: IconButton(
                      icon: Icon(Icons.person),
                      iconSize: 32,
                      color: Constants.main500,
                      padding: EdgeInsets.only(left: 16, right: 16),
                      onPressed: () {},
                    ),
                  ),
                  InputBox(
                    name: 'birthday',
                    placeholder: '생일 (MM-DD 형식)',
                    prefixIcon: IconButton(
                      icon: Icon(Icons.cake),
                      iconSize: 32,
                      color: Constants.main500,
                      padding: EdgeInsets.only(left: 16, right: 16),
                      onPressed: () {},
                    ),
                  ),
                ])),
              ),
            ],
          ),
        )));
  }
}
