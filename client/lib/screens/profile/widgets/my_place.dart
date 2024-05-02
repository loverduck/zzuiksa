import 'package:flutter/material.dart';

import 'package:client/constants.dart';

class MyPlace extends StatefulWidget {
  const MyPlace({super.key});

  @override
  State<MyPlace> createState() => _MyPlaceState();
}

class _MyPlaceState extends State<MyPlace> {
  final postList = [
    {
      "title": "멀캠",
      "category": "직장",
      "address1": "서울 강남구 테헤란로 212",
      "address2": "멀티캠퍼스 역삼",
    },
    {
      "title": "성심당",
      "category": "음식점",
      "address1": "대전 중구 대종로 480번길 15",
      "address2": "asdf",
    },
  ];

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return ListView.builder(
      itemCount: postList.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          // width: MediaQuery.of(context).size.width,
          height: 100,
          child: Container(
            width: 200,
              height: 80,
              decoration: BoxDecoration(
                  color: Constants.main100,
                  border: Border.all(width: 3, color: Constants.main600),
                  borderRadius: BorderRadius.circular(30)),
              padding: EdgeInsets.only(left: 10),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(Icons.shopping_bag, size: 32),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(postList[index]["title"].toString(),style: textTheme.displaySmall),
                          Text(postList[index]["address1"].toString(),style: textTheme.displaySmall),
                        ]),
                    Icon(Icons.zoom_in, size: 40),
                  ])),
        );
      },
    );
  }
}
