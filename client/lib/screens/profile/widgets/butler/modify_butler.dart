import 'package:flutter/material.dart';

import '../input_box.dart';

class ModifyButler extends StatefulWidget {
  const ModifyButler({super.key});

  @override
  State<ModifyButler> createState() => _ModifyButlerState();
}

class _ModifyButlerState extends State<ModifyButler> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(80.0),
          child: AppBar(
            backgroundColor: Colors.transparent,
            title: Text('집사 정보 수정', style: textTheme.displayLarge),
            centerTitle: true,
            toolbarHeight: 80.0,
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
