import 'package:flutter/material.dart';

import 'package:client/widgets/header.dart';

class Collection extends StatelessWidget {
  const Collection({super.key});

  @override
  Widget build(context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(80.0),
          child: Header(title:'집사 도감'),
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
                          SizedBox(height: 16),
                          Text('집사의 다양한 모습들을 모아 보세요', style: textTheme.displaySmall),
                          Text('각 칸을 클릭하면 수집 조건을 알 수 있어요', style: textTheme.displaySmall),

                        ])),
                  ),
                ],
              ),
            )));
  }
}
