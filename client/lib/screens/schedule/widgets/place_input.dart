import 'package:client/constants.dart';
import 'package:client/screens/schedule/model/schedule_model.dart';
import 'package:client/screens/schedule/service/schedule_api.dart';
import 'package:client/screens/schedule/utils/second_contvertor.dart';
import 'package:client/screens/schedule/widgets/input_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PlaceInput extends StatefulWidget {
  const PlaceInput({
    super.key,
    required this.selectedType,
    required this.inputTitleText,
    required this.marginBox,
    required this.setType,
    required this.setPlace,
    this.toPlace,
    this.fromPlace,
    this.arrivalDate,
    this.arrivalTime,
  });

  final String selectedType;
  final Function inputTitleText;
  final SizedBox marginBox;
  final Function setType;
  final Function setPlace;
  final Place? toPlace;
  final Place? fromPlace;
  final String? arrivalDate;
  final String? arrivalTime;

  @override
  State<PlaceInput> createState() => _PlaceInputState();
}

const Map<String, String> transports = {
  "TRANSIT": "대중교통",
  "CAR": "자가용",
  "WALK": "도보",
};

class _PlaceInputState extends State<PlaceInput> {
  String _selectedType = "PUBTRANS";
  Place _toPlace = Place();
  Place _fromPlace = Place();
  Map<String, dynamic>? routeRes;
  String transportTimeText = "";
  String errorMsg = "";

  ButtonStyle placeInputStyle = ElevatedButton.styleFrom(
    padding: const EdgeInsets.symmetric(horizontal: 32.0),
    elevation: 0,
    backgroundColor: Constants.main200.withOpacity(0.5),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
  );

  void moveToSearch(String type) async {
    Place prevPlace = Place();

    if (type == "from" && widget.fromPlace != null) {
      prevPlace = widget.fromPlace!;
    } else if (type == "to" && widget.toPlace != null) {
      prevPlace = widget.toPlace!;
    }
    // 사용자가 검색한 위치 저장
    final Place place =
        await Navigator.pushNamed(context, "/schedule/search") as Place;

    setState(() {
      if (type == "from") {
        _fromPlace = place;
        widget.setPlace("from", _fromPlace);
      } else {
        _toPlace = place;
        widget.setPlace("to", _toPlace);
      }
      if (place.name == null) {
        transportTimeText = "";
      } else {
        getTransport(_selectedType);
      }
    });
  }

  void getTransport(String item) async {
    print("getTransport: $item");
    setState(() {
      if (_fromPlace.name == null || _toPlace.name == null) {
        transportTimeText = "";
      } else {
        transportTimeText = "계산 중입니다";
      }
    });

    late String time;
    late int seconds;
    _selectedType = item;
    widget.setType(item);

    if (_fromPlace.name != null &&
        _fromPlace.name!.isNotEmpty &&
        _toPlace.name != null &&
        _toPlace.name!.isNotEmpty) {
      time = "";
      routeRes = await getRoute(
        _selectedType,
        _fromPlace,
        _toPlace,
        widget.arrivalDate == null || widget.arrivalTime == null
            ? null
            : "${widget.arrivalDate}T${widget.arrivalTime}",
      );
      if (routeRes?["status"] == "success") {
        seconds = routeRes?["data"]["time"];
        time = secondsConvertor(seconds);
        errorMsg = "";
      } else {
        errorMsg = "잠시 후 다시 시도해주세요.";
      }

      setState(() {
        transportTimeText = "약 $time";
        print("error: $errorMsg, time: $time");
      });
    } else {
      setState(() {
        time = "";
        errorMsg = "";
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _selectedType = widget.selectedType;
  }

  @override
  Widget build(BuildContext context) {
    return InputContainer(
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            widget.inputTitleText("장소"),
            GestureDetector(
              onTap: () => moveToSearch("to"),
              child: Container(
                alignment: Alignment.center,
                width: 230.0,
                height: 40.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Text(
                  _toPlace.name ?? "",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 24.0,
                  ),
                ),
              ),
            ),
          ],
        ),
        // 도착지가 있는 경우 출발지 선택 및 이동 방법 선택
        if (_toPlace.name != null && _toPlace.name!.isNotEmpty) ...[
          widget.marginBox,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              widget.inputTitleText("출발지"),
              GestureDetector(
                onTap: () => moveToSearch("from"),
                child: Container(
                  alignment: Alignment.center,
                  width: 230.0,
                  height: 40.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Text(
                    _fromPlace.name ?? "",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 24.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10.0,
              ),
              const Divider(
                thickness: 1.0,
              ),
              widget.marginBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: transports.entries.map((item) {
                  return ElevatedButton(
                    style: item.key == widget.selectedType
                        ? placeInputStyle.copyWith(
                            backgroundColor: const MaterialStatePropertyAll(
                                Constants.main100),
                            side: const MaterialStatePropertyAll(
                              BorderSide(
                                color: Constants.main400,
                                width: 2.0,
                              ),
                            ),
                          )
                        : placeInputStyle,
                    onPressed: () => getTransport(item.key),
                    child: Text(
                      item.value,
                      style: TextStyle(
                        fontSize: 24.0,
                        color: item.key == widget.selectedType
                            ? Constants.main400
                            : Constants.main500,
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(
                height: 10.0,
              ),
              errorMsg.isEmpty
                  ? Text(
                      "예상 이동 시간: $transportTimeText",
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        fontSize: 20.0,
                        color: Colors.black54,
                      ),
                    )
                  : Text(
                      errorMsg,
                      style: const TextStyle(
                        fontSize: 24.0,
                        color: Colors.red,
                      ),
                    ),
            ],
          ),
        ]
      ]),
    );
  }
}
