import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'widgets/gifticon_list_header.dart';
import 'widgets/gifticon_overview.dart';
import 'widgets/gifticon_list.dart';

class GifticonListScreen extends StatefulWidget {
  static const title = 'Gifticon';
  static const androidIcon = Icon(Icons.card_giftcard);
  static const iosIcon = Icon(CupertinoIcons.news);

  const GifticonListScreen({super.key});

  @override
  State<GifticonListScreen> createState() => _GifticonListScreenState();
}

class _GifticonListScreenState extends State<GifticonListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                GifticonListHeader(),
                GifticonOverview(expiringGifticonsCount: 5),
                SizedBox(height: 10),
              ],
            ),
          ),
          SliverFillRemaining(
            child: GifticonList(),
          ),
        ],
      ),
    );
  }
}