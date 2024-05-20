import 'package:flutter/material.dart';

import 'package:client/constants.dart';
import 'package:client/widgets/header.dart';
import 'package:client/widgets/custom_button.dart';
import 'collection.dart';
import 'sentences.dart';
import 'modify_butler.dart';

class MyButler extends StatelessWidget {
  const MyButler({super.key});

  @override
  Widget build(context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(80.0),
          child: Header(title:'집사 정보'),
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
                  Sentences(),
                  Image(
                    image: AssetImage('assets/images/temp.png'),
                    width: 120,
                    height: 120,
                  ),
                  SizedBox(height: 16),
                  Text('햄찌', style: textTheme.displayLarge),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Table(
                          columnWidths: {
                            0: FixedColumnWidth(80.0),
                            1: FixedColumnWidth(160.0),
                          },
                          children: [
                            TableRow(children: [
                              Text('집사 말투',
                                  style: TextStyle(
                                      color: Constants.main400, fontSize: 22),
                                  textAlign: TextAlign.center),
                              Text('귀여운 말투',
                                  style: textTheme.displaySmall,
                                  textAlign: TextAlign.center)
                            ]),
                            TableRow(children: [
                              Text('집사 레벨',
                                  style: TextStyle(
                                      color: Constants.main400, fontSize: 22),
                                  textAlign: TextAlign.center),
                              Text('Lv. 1',
                                  style: textTheme.displaySmall,
                                  textAlign: TextAlign.center)
                            ]),
                            TableRow(children: [
                              Text('집사 경험치',
                                  style: TextStyle(
                                      color: Constants.main400, fontSize: 22),
                                  textAlign: TextAlign.center),
                              Text('0 / 200',
                                  style: textTheme.displaySmall,
                                  textAlign: TextAlign.center)
                            ]),
                            TableRow(children: [
                              Text('집사 상태',
                                  style: TextStyle(
                                      color: Constants.main400, fontSize: 22),
                                  textAlign: TextAlign.center),
                              Text('행복',
                                  style: textTheme.displaySmall,
                                  textAlign: TextAlign.center)
                            ]),
                          ],
                        ),
                      ],
                    ),
                  )
                ])),
              ),
              CustomButton(
                text: '수정하기',
                func: () {
                  // Navigator.push(
                  //     context, MaterialPageRoute(builder: (context) => ModifyButler()));
                  showDialog<void>(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('준비 중', style: textTheme.displayMedium),
                        content: Text('준비 중인 기능이에요!', style: textTheme.displaySmall),
                      );
                    },
                  );
                },
              ),
              SizedBox(height: 8),
              CustomButton(
                text: '도감보기',
                color: 100,
                func: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => Collection()));
                },
              ),
            ],
          ),
        )));
  }
}
