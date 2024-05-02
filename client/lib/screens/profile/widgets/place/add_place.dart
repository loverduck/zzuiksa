import 'package:client/constants.dart';
import 'package:client/screens/profile/widgets/place/spot_initialize_button.dart';
import 'package:client/screens/profile/widgets/place/spot_pick_button.dart';
import 'package:flutter/material.dart';

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
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                      InputBox(
                        name: 'address1',
                        placeholder: '주소를 입력하세요',
                        suffixIcon: IconButton(
                            icon: Icon(Icons.search),
                            iconSize: 32,
                            color: Constants.main600,
                            onPressed: () {
                              showDialog<void>(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children:[
                                        Text('지도에서 주소 찾기', style: textTheme.displayMedium,),
                                        Icon(Icons.close)
                                      ]),
                                      content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Container(
                                              width: 300,
                                              height: 300,
                                              decoration: BoxDecoration(
                                                color: Constants.green300,
                                                border: Border.all(
                                                    width: 3,
                                                    color: Constants.main500),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                            ),
                                            SizedBox(height: 16),
                                            SpotPickButton(),
                                            SizedBox(height: 8),
                                            SpotInitializeButton(),
                                          ]),
                                      backgroundColor: Constants.main200,
                                    );
                                  });
                            }),
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
