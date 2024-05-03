import 'package:client/constants.dart';
import 'package:flutter/material.dart';

import 'package:client/widgets/custom_button.dart';
import '../input_box.dart';

class AddPlace extends StatefulWidget {
  const AddPlace({super.key});

  @override
  State<AddPlace> createState() => _AddPlaceState();
}

class _AddPlaceState extends State<AddPlace> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(80.0),
          child: AppBar(
            backgroundColor: Colors.transparent,
            title: Text('새 주소 등록', style: textTheme.displayLarge),
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
                  Row(
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
                  SizedBox(height: 8),
                  InputBox(
                    name: 'address1',
                    placeholder: '지도에서 장소를 선택하세요',
                    suffixIcon: IconButton(
                        icon: Icon(Icons.close),
                        iconSize: 32,
                        color: Constants.main600,
                        onPressed: () {}),
                  ),
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
