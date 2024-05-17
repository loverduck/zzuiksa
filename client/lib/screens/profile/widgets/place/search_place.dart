import 'dart:async';

import 'package:client/constants.dart';
import 'package:client/widgets/header.dart';
import 'package:client/screens/profile/model/place_model.dart';
import 'package:client/screens/profile/service/place_api.dart';

import 'package:flutter/material.dart';
import 'package:kakao_map_plugin/kakao_map_plugin.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:provider/provider.dart';

class SearchPlace extends StatefulWidget {
  const SearchPlace({super.key});

  @override
  State<SearchPlace> createState() => _SearchPlaceState();
}

class _SearchPlaceState extends State<SearchPlace> {
  TextEditingController searchEditingController = TextEditingController();
  AutoScrollController scrollController = AutoScrollController();
  late Place? selectedPlace;
  late String? selectedAddress;

  // 사용자의 입력이 없는 걸 판단하기 위한 타이머
  Timer? searchTimer;
  late KakaoMapController mapController;
  List<dynamic> places = [];
  int? selectedPlaceIndex;

  late LatLng center;
  Set<Marker> markers = {};
  List<KeywordAddress> list = [];
  String info = "";

  SizedBox boxMargin = const SizedBox(
    height: 20.0,
  );

  void moveToBack() {
    Navigator.pop(context, selectedPlace);
  }

  void onChangeKeywordHandler(keyword) {
    selectedPlaceIndex = null;

    const duration = Duration(microseconds: 2000);
    if (searchTimer != null) {
      searchTimer!.cancel();
    }
    searchTimer = Timer(duration, () => searchPlaces(keyword));
  }

  void onSelectPlaceHandler(place) {
    selectedPlace = Place(
        name: place.placeName,
        lat: double.parse(place.y!),
        lng: double.parse(place.x!));
  }

  // 검색 결과 리스트 가져오기
  void searchPlaces(text) async {
    list.clear();

    final center = await mapController.getCenter();

    final result = await mapController.keywordSearch(
      KeywordSearchRequest(
        keyword: text,
        y: center.latitude,
        x: center.longitude,
        radius: 3000,
        sort: SortBy.distance,
      ),
    );

    List<LatLng> bounds = [];
    for (var item in result.list) {
      LatLng latLng =
          LatLng(double.parse(item.y ?? ""), double.parse(item.x ?? ""));

      bounds.add(latLng);

      Marker marker = Marker(
        markerId: item.id ?? UniqueKey().toString(),
        latLng: latLng,
      );

      markers.add(marker);
    }

    if (bounds.isNotEmpty) {
      await mapController.fitBounds(bounds);
    }

    setState(() {
      list.addAll(result.list);
    });
  }

  @override
  void initState() {
    super.initState();
    center = LatLng(37.501271678934685, 127.03959900167186);
    selectedPlace = Place();
  }

  @override
  void dispose() {
    // 컨트롤러 정리
    searchEditingController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final provider = Provider.of<PlaceApi>(context);

    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(80.0),
          child: Header(
            title: '등록할 위치 선택',
            buttonList: [
              IconButton(
                icon: Icon(Icons.check),
                padding: EdgeInsets.all(32),
                iconSize: 32,
                onPressed: () {
                  print('complete button clicked');
                  createPlaceInfo(selectedPlace!);
                  // provider.createPlaceInfo(selectedPlace!);
                  Navigator.pop(context);
                },
              )
            ],
          ),
        ),
        extendBodyBehindAppBar: true,
        body: SafeArea(
            child: SingleChildScrollView(
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              child: TextField(
                controller: searchEditingController,
                onChanged: onChangeKeywordHandler,
                onSubmitted: searchPlaces,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Constants.main100,
                  contentPadding: EdgeInsets.only(left: 32, top: 16, bottom: 8),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      width: 3,
                      color: Constants.main400,
                      style: BorderStyle.solid,
                    ),
                    borderRadius: BorderRadius.circular(36),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      width: 3,
                      color: Constants.main500,
                      style: BorderStyle.solid,
                    ),
                    borderRadius: BorderRadius.circular(36),
                  ),
                  labelText: '지역 또는 장소명',
                  labelStyle:
                      const TextStyle(color: Constants.main300, fontSize: 24),
                  prefixIcon: IconButton(
                    icon: Icon(Icons.search),
                    iconSize: 32,
                    color: Constants.main500,
                    padding: EdgeInsets.only(left: 16, right: 16),
                    onPressed: () {},
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {},
                  ),
                ),
              ),
            ),
            Container(
              height: 240,
              padding: EdgeInsets.only(left: 16, right: 16),
              child: ListView.builder(
                controller: scrollController,
                itemCount: list.length,
                itemBuilder: (BuildContext context, int index) {
                  return Row(
                    children: [
                      const Icon(
                        Icons.location_on_outlined,
                        size: 32,
                        color: Constants.main400,
                      ),
                      Expanded(
                        child: AutoScrollTag(
                          key: ValueKey(index),
                          index: index,
                          controller: scrollController,
                          child: ListTile(
                            title: Text(list[index].placeName ?? ""),
                            subtitle: Row(
                              children: [
                                Text(list[index].addressName ?? ""),
                                const SizedBox(
                                  width: 20.0,
                                ),
                                Text("${list[index].distance}m"),
                              ],
                            ),
                            trailing: selectedPlaceIndex == index
                                ? const Icon(
                                    Icons.check_circle,
                                    size: 32,
                                    color: Constants.green300,
                                  )
                                : null,
                            onTap: () {
                              setState(() {
                                selectedPlaceIndex = index;

                                onSelectPlaceHandler(list[index]);
                                mapController.setCenter(LatLng(
                                    double.parse(list[index].y!),
                                    double.parse(list[index].x!)));
                                mapController.setLevel(3);

                                FocusScope.of(context).unfocus();
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            SizedBox(height: 24),
            Container(
              width: 360,
              height: 360,
              decoration: BoxDecoration(
                  color: Constants.green300,
                  border: Border.all(width: 4, color: Constants.green300),
                  borderRadius: BorderRadius.circular(10)),
              child: KakaoMap(
                onMapCreated: ((controller) {
                  mapController = controller;
                }),
                onMarkerTap: (markerId, latLng, zoomLevel) {
                  for (var item in list) {
                    if (item.id == markerId) {
                      mapController.setCenter(latLng);
                      mapController.setLevel(3);
                      setState(() {
                        selectedPlaceIndex = list.indexOf(item);
                        scrollController.scrollToIndex(selectedPlaceIndex!,
                            duration: const Duration(milliseconds: 500),
                            preferPosition: AutoScrollPosition.begin);
                        onSelectPlaceHandler(list[selectedPlaceIndex!]);
                      });
                    }
                  }
                },
                center: center,
                markers: markers.toList(),
                // onMapTap: ,
              ),
            ),
          ]),
        )));
  }
}
