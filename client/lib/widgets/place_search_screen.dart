import 'dart:async';

import 'package:client/constants.dart';
import 'package:client/screens/schedule/model/schedule_model.dart';
import 'package:client/screens/schedule/widgets/input_delete_icon.dart';
import 'package:client/screens/schedule/widgets/loading_dialog.dart';
import 'package:client/widgets/location_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:kakao_map_plugin/kakao_map_plugin.dart';
import 'package:provider/provider.dart';
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
  bool _isLocationInitialized = false;
  late LocationModel locationModel;

  // 사용자의 입력이 없는 걸 판단하기 위한 타이머
  Timer? searchTimer;
  late KakaoMapController mapController;
  List<dynamic> places = [];
  int? selectedPlaceIndex;
  bool isSearching = false;

  LatLng center = LatLng(37.50129420028603, 127.03961032272223);
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

    if (keyword.isEmpty) return;

    const duration = Duration(milliseconds: 1500);
    searchTimer?.cancel();
    searchTimer = Timer(duration, () {
      setState(() {
        isSearching = true;
      });
      searchPlaces(keyword);
    });
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

    try {
      final center = await mapController.getCenter();

      final result = await mapController.keywordSearch(
        KeywordSearchRequest(
          keyword: text,
          y: center.latitude,
          x: center.longitude,
          sort: SortBy.distance,
        ),
      );

      List<LatLng> bounds = [];
      for (var item in result.list) {
        LatLng latLng =
            LatLng(double.parse(item.y ?? "0"), double.parse(item.x ?? "0"));

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
        isSearching = false;
      });
    } catch (e) {
      print("search error: $e");
    }
  }

  @override
  void didChangeDependencies() {
    if (!_isLocationInitialized) {
      // 기본 값으로 멀캠 위치
      locationModel = Provider.of<LocationModel>(context);

      Future.delayed(Duration.zero, () async {
        Map<String, dynamic> permission = await checkLocationPermission();

        if (permission["status"] == "granted") {
          await locationModel.getCurrentLocation();
          Position currentPosition = locationModel.currentPostion;

          _isLocationInitialized = true;

          setState(() {
            center =
                LatLng(currentPosition.latitude, currentPosition.longitude);
            markers.add(Marker(
              markerId: "current",
              latLng: center,
            ));

            mapController.setCenter(center);
          });
        }
        // }
      });
    }
    selectedPlace = Place();

    super.didChangeDependencies();
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
              child: isSearching
                  ? Column(
                      children: [
                        const SizedBox(
                          height: 24.0,
                        ),
                        SizedBox(
                          width: 36.0,
                          height: 36.0,
                          child: LoadingDialog.showIndicator(),
                        ),
                      ],
                    )
                  : ListView.builder(
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
