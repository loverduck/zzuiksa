import 'package:client/screens/gifticon/util/%20imminent_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'widgets/list/gifticon_list_header.dart';
import 'widgets/list/gifticon_overview.dart';
import 'widgets/list/gifticon_list.dart';

import 'package:client/screens/gifticon/service/gifticon_api.dart';
import 'package:client/screens/gifticon/model/gifticon_model.dart';

class GifticonListScreen extends StatefulWidget {
  static const title = 'Gifticon';
  static const androidIcon = Icon(Icons.card_giftcard);
  static const iosIcon = Icon(CupertinoIcons.news);

  const GifticonListScreen({super.key});

  @override
  State<GifticonListScreen> createState() => _GifticonListScreenState();
}

class _GifticonListScreenState extends State<GifticonListScreen> {
  List<Gifticon> gifticons = [];

  @override
  void initState() {
    super.initState();
    fetchGifticons();
  }

  Future<void> fetchGifticons() async {
    try {
      final List<Gifticon> fetchedGifticons = (await getGifticonList()).cast<Gifticon>();
      setState(() {
        gifticons = fetchedGifticons;
      });
    } catch (e) {
      throw Exception('Failed to load gifticons: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    int expiringCount = countExpiringGifticons(gifticons);

    return Scaffold(
      body: CustomScrollView(
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
              child: GifticonList(gifticons: gifticons),
            ),
          ),
        ],
      ),
    );
  }
}