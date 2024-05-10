import 'package:client/constants.dart';
import 'package:client/screens/schedule/model/schedule_model.dart';
import 'package:client/screens/schedule/service/schedule_api.dart';
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
  });

  final String selectedType;
  final Function inputTitleText;
  final SizedBox marginBox;
  final Function setType;
  final Function setPlace;
  final Place? toPlace;
  final Place? fromPlace;

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

  ButtonStyle PlaceInputtyle = ElevatedButton.styleFrom(
    padding: const EdgeInsets.symmetric(horizontal: 32.0),
    elevation: 0,
    backgroundColor: Constants.main200.withOpacity(0.5),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
  );

  void moveToSearch(String type) async {
    Place prevPlace = Place();

    if (type == "from" && widget.fromPlace != null) {
      prevPlace = widget.fromPlace!;
    } else if (type == "to" && widget.toPlace != null) {
      prevPlace = widget.toPlace!;
    }
    // 사용자가 검색한 위치 저장
    final Place place = await Navigator.pushNamed(context, "/schedule/search",
        arguments: prevPlace.name) as Place;

    setState(() {
      if (type == "from") {
        _fromPlace = place;
        widget.setPlace("from", _fromPlace);
      } else {
        _toPlace = place;
        widget.setPlace("to", _toPlace);
      }
    });

    getRoute(_selectedType, _fromPlace, _toPlace);
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
              const Divider(
                thickness: 1.0,
              ),
              widget.marginBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: transports.entries.map((item) {
                  return ElevatedButton(
                    style: item.key == widget.selectedType
                        ? PlaceInputtyle.copyWith(
                            backgroundColor: const MaterialStatePropertyAll(
                                Constants.main100),
                            side: const MaterialStatePropertyAll(
                              BorderSide(
                                color: Constants.main400,
                                width: 3.0,
                              ),
                            ),
                          )
                        : PlaceInputtyle,
                    onPressed: () => {
                      _selectedType = item.key,
                      widget.setType(item.key),
                      getRoute(_selectedType, _fromPlace, _toPlace),
                    },
                    child: Text(
                      item.value,
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: item.key == widget.selectedType
                            ? FontWeight.bold
                            : FontWeight.normal,
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
              const Text(
                "예상 이동 시간: ",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ]
      ]),
    );
  }
}
