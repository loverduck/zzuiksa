import 'package:client/constants.dart';
import 'package:flutter/material.dart';

import 'package:client/widgets/header.dart';
import 'package:client/widgets/input_box.dart';
import 'package:client/widgets/custom_button.dart';

class AddPlace extends StatefulWidget {
  const AddPlace({super.key});

  @override
  State<AddPlace> createState() => _AddPlaceState();
}

class _AddPlaceState extends State<AddPlace> {
  var address1 = TextEditingController(); // 닉네임 입력 저장
  var name = TextEditingController(); // 생일 입력 저장

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(80.0),
          child: Header(
            title: '새 주소 추가',
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
                  Container(
                    width: 320,
                    height: 240,
                    margin: EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: Constants.green300,
                      border: Border.all(width: 3, color: Constants.main500),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(12),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CustomButton(
                            text: '장소선택',
                            size: 'small',
                            func: () {
                              print('select button clicked');
                            },
                          ),
                          CustomButton(
                            text: '현위치로',
                            size: 'small',
                            color: 200,
                            func: () {
                              print('here button clicked');
                            },
                          ),
                        ]),
                  ),
                  InputBox(
                    controller: address1,
                    name: 'address1',
                    placeholder: '지도에서 장소를 선택하세요',
                    suffixIcon: IconButton(
                        icon: Icon(Icons.close),
                        iconSize: 32,
                        color: Constants.main600,
                        onPressed: () {}),
                  ),
                  InputBox(
                    controller: name,
                    name: 'name',
                    placeholder: '장소명을 입력하세요',
                    suffixIcon: IconButton(
                        icon: Icon(Icons.close),
                        iconSize: 32,
                        color: Constants.main600,
                        onPressed: () {}),
                  ),
                ])),
              ),
            ],
          ),
        )));
  }
}
