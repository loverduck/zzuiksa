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

    return SingleChildScrollView(child: Column(
      children: [
        myPlaceList == null
            ? Container()
            : Container(
                height: 124.0 * myPlaceList.length!,
                child: ListView.builder(
                  itemCount: myPlaceList.length,
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
                              border: Border.all(
                                  width: 3, color: Constants.main600),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          myPlaceList[index].name!,
                                          style: textTheme.displaySmall),
                                      // Text(
                                      //     myPlaceList[index].address!,
                                      //     style: textTheme.displaySmall),
                                    ]),
                                IconButton(icon: Icon(Icons.zoom_in),
                                    iconSize: 40, color: Constants.main600,
                                onPressed: () {
                                  // Navigator.pushNamed(context, '/gifticon_detail_screen', arguments: gifticon['id'])
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) => DetailPlace(
                                        placeId: ModalRoute.of(context)!.settings.arguments as int,
                                      )));
                                },
                                ),
                              ])),
                    );
                  },
                )),
        Container(
          width: 344,
          height: 100,
          margin: EdgeInsets.only(top: 12, bottom: 36),
          decoration: BoxDecoration(
              border: Border.all(width: 3, color: Constants.main600),
              borderRadius: BorderRadius.circular(30)),
          child: TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SearchPlace()));
              },
              child: Icon(
                Icons.add,
                size: 32,
              )),
        ),
      ],
    ));
  }
}
