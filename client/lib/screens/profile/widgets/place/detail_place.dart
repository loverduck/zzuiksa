import 'package:client/constants.dart';
import 'package:flutter/material.dart';

import 'package:client/widgets/header.dart';
import 'package:client/widgets/input_box.dart';
import 'package:client/widgets/custom_button.dart';

class DetailPlace extends StatefulWidget {
  final int? placeId;
  const DetailPlace({super.key, this.placeId});

  @override
  State<DetailPlace> createState() => _DetailPlaceState();
}

class _DetailPlaceState extends State<DetailPlace> {

  //GifticonDetailScreen 참고해야지... 

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(80.0),
          child: Header(
            title: '주소 확인',
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
              child: Center(child: Text(""))
              ),
            ));
  }
}
