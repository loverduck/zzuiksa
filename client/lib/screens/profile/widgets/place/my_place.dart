import 'package:flutter/material.dart';

import 'package:client/screens/profile/widgets/place/add_place.dart';
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

    return Column(
      children: [
        Container(
            height: 124 * 2,
            child: ListView.builder(
              itemCount: postList.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  // width: MediaQuery.of(context).size.width,
                  height: 100,
                  margin: EdgeInsets.all(12),
                  child: Container(
                      width: 200,
                      height: 80,
                      decoration: BoxDecoration(
                          color: Constants.main100,
                          border:
                              Border.all(width: 3, color: Constants.main600),
                          borderRadius: BorderRadius.circular(30)),
                      padding: EdgeInsets.only(left: 10),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                  color: Constants.main400,
                                  borderRadius: BorderRadius.circular(12)),
                              child: Icon(Icons.shopping_bag,
                                  size: 28, color: Constants.main100),
                            ),
                            Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(postList[index]["title"].toString(),
                                      style: textTheme.displaySmall),
                                  Text(postList[index]["address1"].toString(),
                                      style: textTheme.displaySmall),
                                ]),
                            Icon(Icons.zoom_in,
                                size: 40, color: Constants.main600),
                          ])),
                );
              },
            )),
        // Container(
        //   width: 344,
        //   height: 100,
        //   margin: EdgeInsets.only(top: 12, bottom: 36),
        //   decoration: BoxDecoration(
        //       border: Border.all(width: 3, color: Constants.main600),
        //       borderRadius: BorderRadius.circular(30)),
        //   child: TextButton(
        //       onPressed: () {
        //         Navigator.push(context,
        //             MaterialPageRoute(builder: (context) => AddPlace()));
        //       },
        //       child: Icon(
        //         Icons.add,
        //         size: 32,
        //       )),
        // ),
      ],
    );
  }
}
