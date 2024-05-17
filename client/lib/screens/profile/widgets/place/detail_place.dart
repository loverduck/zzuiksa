import 'package:flutter/material.dart';

import 'package:client/widgets/header.dart';
import 'package:client/constants.dart';
import 'package:client/screens/profile/model/place_model.dart';
import 'package:client/screens/profile/service/place_api.dart';
import 'package:client/screens/schedule/widgets/snackbar_text.dart';

class PlaceDetailScreen extends StatefulWidget {
  const PlaceDetailScreen({super.key});

  @override
  State<PlaceDetailScreen> createState() => _PlaceDetailScreenState();
}

class _PlaceDetailScreenState extends State<PlaceDetailScreen> {
  late int placeId;
  late Place place;

  void _getPlace(int placeId, BuildContext context) async {
    Place res = await getPlaceInfo(placeId);
    print(res);

    if (res != null) {
      setState(() {
        place = res;
        place.placeId = placeId;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: SnackBarText(
            message: "로딩에 실패했습니다. 잠시 후 다시 시도해주세요",
          ),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    place = Place();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (ModalRoute.of(context)?.settings.arguments != null) {
        final args = ModalRoute.of(context)?.settings.arguments as Map;
        placeId = args['placeId'];
        _getPlace(placeId, context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: Header(
          title: '${place.name}',
        ),
      ),
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Container(
                  width: 320,
                  height: 240,
                  margin: EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Constants.green300,
                    border: Border.all(width: 3, color: Constants.main500),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
