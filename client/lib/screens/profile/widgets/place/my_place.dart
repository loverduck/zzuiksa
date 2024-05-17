import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:client/constants.dart';
import 'package:client/screens/profile/widgets/place/search_place.dart';
import 'package:client/screens/profile/service/place_api.dart';
import 'package:client/screens/profile/model/place_model.dart';

import 'detail_place.dart';

class MyPlace extends StatefulWidget {
  const MyPlace({super.key});

  @override
  State<MyPlace> createState() => _MyPlaceState();
}

class _MyPlaceState extends State<MyPlace> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final placeProvider = Provider.of<PlaceApi>(context);
    final myPlaceList = placeProvider.placeList.places;
    print(myPlaceList);

    return SingleChildScrollView(
        child: Scrollbar(
            controller: _scrollController,
            thickness: 20.0, // 스크롤 너비
            radius: Radius.circular(8.0), // 스크롤 라운딩

            thumbVisibility: true, // 항상 보이기 여부
            child: Column(
              children: [
                myPlaceList == null
                    ? Container()
                    : Container(
                        height: 104.0 * myPlaceList.length!,
                        child: ListView.builder(
                          controller: _scrollController,
                          itemCount: myPlaceList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              // width: MediaQuery.of(context).size.width,
                              height: 80,
                              margin: EdgeInsets.all(12),
                              child: Container(
                                  width: 200,
                                  decoration: BoxDecoration(
                                      color: Constants.main100,
                                      border: Border.all(
                                          width: 3, color: Constants.main600),
                                      borderRadius: BorderRadius.circular(30)),
                                  padding: EdgeInsets.only(left:24,right:24),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(myPlaceList[index].name!,
                                            style: textTheme.displaySmall,),
                                        Row(children:[
                                          Container(
                                            width: 50,
                                            height: 50,
                                            decoration: BoxDecoration(
                                                color: Constants.main400,
                                                borderRadius:
                                                BorderRadius.circular(12)),
                                            child: IconButton(
                                              icon: Icon(Icons.zoom_in),
                                              iconSize: 28,
                                              color: Constants.main100,
                                              onPressed: () {
                                                Navigator.pushNamed(context,
                                                    '/place/detail', arguments: {
                                                      "placeId":
                                                      myPlaceList[index].placeId!
                                                    });
                                              },
                                            ),
                                          ),
                                          Container(
                                            width: 50,
                                            height: 50,
                                            decoration: BoxDecoration(
                                                color: Constants.main200,
                                                borderRadius:
                                                BorderRadius.circular(12)),
                                            child: IconButton(
                                              icon: Icon(Icons.close),
                                              iconSize: 28,
                                              color: Constants.main400,
                                              onPressed: () {

                                              },
                                            ),
                                          ),
                                        ]),
                                      ])),
                            );
                          },
                        )),
                Container(
                  width: 344,
                  height: 80,
                  margin: EdgeInsets.only(top: 12, bottom: 36),
                  decoration: BoxDecoration(
                      border: Border.all(width: 3, color: Constants.main600),
                      borderRadius: BorderRadius.circular(30)),
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SearchPlace()));
                    },
                    child: Icon(Icons.add, size: 32),
                  ),
                ),
              ],
            )));
  }
}
