import 'dart:async';

import 'package:client/screens/gifticon/model/gifticon_preview_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'widgets/list/gifticon_list_header.dart';
import 'widgets/list/gifticon_overview.dart';
import 'widgets/list/gifticon_list.dart';

import 'package:client/screens/gifticon/service/gifticon_api.dart';

class GifticonListScreen extends StatefulWidget {
  static const title = 'Gifticon';
  static const androidIcon = Icon(Icons.card_giftcard);
  static const iosIcon = Icon(CupertinoIcons.news);

  const GifticonListScreen({super.key});

  @override
  State<GifticonListScreen> createState() => _GifticonListScreenState();
}

class _GifticonListScreenState extends State<GifticonListScreen> {
  List<GifticonPreview> gifticons = [];
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    fetchGifticons();
    _setupTimer();
  }

  void _setupTimer() {
    _timer = Timer.periodic(Duration(seconds: 10), (Timer t) => fetchGifticons());
  }

  @override
  void dispose() {
    _timer?.cancel();  // Timer가 활성화되어 있을 경우 dispose 시에 반드시 취소해야 함
    super.dispose();
  }

  Future<void> fetchGifticons() async {
    try {
      final List<GifticonPreview> fetchedGifticons = await getGifticonList();
      setState(() {
        gifticons = fetchedGifticons;
      });
      print("fetchGifticons");
      print(gifticons);
    } catch (e) {
      throw Exception('Failed to load gifticons: $e');
    }
  }

  int countExpiringGifticons() {
    DateTime now = DateTime.now();
    final weekLater = now.add(Duration(days: 7));

    return gifticons.where((gifticon) {
      if (gifticon.isUsed != 'UNUSED' && gifticon.isUsed != 'INUSE') {
        return false;
      }

      DateTime endDate;
      try {
        endDate = DateFormat('yyyy-MM-dd').parse(gifticon.endDate!);
      } catch (e) {
        print("Date parsing error: $e");
        return false;
      }

      return endDate.isBefore(weekLater) && !endDate.isBefore(now);
    }).length;
  }

  String getStatusStamp(GifticonPreview gifticon) {
    DateTime now = DateTime.now();
    DateTime endDate = DateFormat('yyyy-MM-dd').parse(gifticon.endDate!);

    if (gifticon.isUsed == 'USED') {
      return 'assets/stamps/used_stamp.png';
    } else if ((gifticon.isUsed == 'UNUSED' || gifticon.isUsed == 'INUSE') && endDate.isBefore(now)) {
      return 'assets/stamps/expired_stamp.png';
    } else if (gifticon.isUsed == 'INUSE' && gifticon.remainMoney != null && gifticon.remainMoney! > 0) {
      return 'assets/stamps/in_use_stamp.png';
    }

    return ''; // No stamp needed
  }

  @override
  Widget build(BuildContext context) {
    int expiringCount = countExpiringGifticons();

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: fetchGifticons,
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  GifticonListHeader(),
                  GifticonOverview(expiringGifticonsCount: expiringCount),
                  SizedBox(height: 10),
                ],
              ),
            ),
            SliverFillRemaining(
              child: Padding(
                padding: EdgeInsets.all(18.0),
                child: GifticonList(
                  gifticons: gifticons,
                  onRefresh: fetchGifticons,
                  getStatusStamp: getStatusStamp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}