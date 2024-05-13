import 'dart:async';

import 'package:client/constants.dart';
import 'package:client/screens/schedule/model/schedule_model.dart';
import 'package:client/screens/schedule/widgets/input_delete_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kakao_map_plugin/kakao_map_plugin.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class SchedulePlaceSearchScreen extends StatefulWidget {
  const SchedulePlaceSearchScreen({super.key});

  @override
  State<SchedulePlaceSearchScreen> createState() =>
      _SchedulePlaceSearchScreenState();
}

class _SchedulePlaceSearchScreenState extends State<SchedulePlaceSearchScreen> {
  TextEditingController searchEditingController = TextEditingController();
  AutoScrollController scrollController = AutoScrollController();
  late Place? selectedPlace;

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
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Constants.main200,
        leading: IconButton(
            onPressed: moveToBack, icon: const Icon(Icons.arrow_back)),
      ),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.0),
                border: Border.all(color: Colors.black, width: 3.0)),
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            margin: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                const Icon(Icons.search_sharp),
                Expanded(
                  child: TextField(
                    controller: searchEditingController,
                    onChanged: onChangeKeywordHandler,
                    onSubmitted: searchPlaces,
                    textAlignVertical: TextAlignVertical.center,
                    style: const TextStyle(
                      fontSize: 24.0,
                      height: 1.0,
                    ),
                    decoration: InputDecoration(
                      suffixIcon: InputDeleteIcon(
                          textEditingController: searchEditingController),
                      hintText: "지역명/장소 검색",
                      hintStyle: const TextStyle(
                        color: Colors.black54,
                        fontSize: 24.0,
                      ),
                      isDense: true,
                      filled: true,
                      fillColor: Colors.white,
                      border: const OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          boxMargin,
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ListView.builder(
                controller: scrollController,
                itemCount: list.length,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      const Icon(Icons.location_on),
                      Expanded(
                        child: AutoScrollTag(
                          key: ValueKey(index),
                          index: index,
                          controller: scrollController,
                          child: ListTile(
                            title: Text(
                              list[index].placeName ?? "",
                              style: const TextStyle(
                                fontSize: 24.0,
                              ),
                            ),
                            subtitle: Row(
                              children: [
                                Text(
                                  list[index].addressName ?? "",
                                  style: const TextStyle(
                                    fontSize: 18.0,
                                  ),
                                ),
                                const SizedBox(
                                  width: 20.0,
                                ),
                                Text(
                                  "${list[index].distance}m",
                                  style: const TextStyle(
                                    fontSize: 18.0,
                                  ),
                                ),
                              ],
                            ),
                            trailing: selectedPlaceIndex == index
                                ? const Icon(Icons.check)
                                : null,
                            onTap: () {
                              setState(() {
                                selectedPlaceIndex = index;

                                onSelectPlaceHandler(list[index]);
                                mapController.setCenter(LatLng(
                                    double.parse(list[index].y!),
                                    double.parse(list[index].x!)));
                                mapController.setLevel(3);
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
          ),
          boxMargin,
          Flexible(
            flex: 1,
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
            ),
          ),
        ],
      ),
    );
  }
}
