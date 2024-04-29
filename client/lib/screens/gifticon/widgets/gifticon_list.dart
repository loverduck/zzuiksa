import 'package:flutter/material.dart';
import 'gifticon_list_item.dart';

class GifticonList extends StatelessWidget {
  final List<Map<String, dynamic>> tempGifticonsList = [
    {
      'gifticonId': 1,
      'url': '/assets/images/tempGifticon.jpeg',
      'name': 'Gifticon 1',
      'store': 'Store A',
      'endDate': '2024-05-31',
      'isUsed': '미사용',
    },
    {
      'gifticonId': 2,
      'url': '/assets/images/tempGifticon.jpeg',
      'name': 'Gifticon 2',
      'store': 'Store B',
      'endDate': '2024-06-30',
      'isUsed': '사용중',
    },
    {
      'gifticonId': 3,
      'url': '/assets/images/tempGifticon.jpeg',
      'name': 'Gifticon 3',
      'store': 'Store C',
      'endDate': '2024-07-31',
      'isUsed': '사용완료',
    },
  ];

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> availableGifticons = [];
    List<Map<String, dynamic>> usedGifticons = [];

    for (var gifticon in tempGifticonsList) {
      if (gifticon['isUsed'] == '사용중' || gifticon['isUsed'] == '미사용') {
        availableGifticons.add(gifticon);
      } else {
        usedGifticons.add(gifticon);
      }
    }

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Gifticon List'),
          bottom: TabBar(
            tabs: [
              Tab(text: '사용 가능'),
              Tab(text: '사용 완료'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ListView.builder(
              itemCount: availableGifticons.length,
              itemBuilder: (context, index) {
                final gifticon = availableGifticons[index];
                return GifticonListItem(
                  gifticonId: gifticon['gifticonId'],
                  url: gifticon['url'],
                  name: gifticon['name'],
                  store: gifticon['store'],
                  endDate: gifticon['endDate'],
                );
              },
            ),
            ListView.builder(
              itemCount: usedGifticons.length,
              itemBuilder: (context, index) {
                final gifticon = usedGifticons[index];
                return GifticonListItem(
                  gifticonId: gifticon['gifticonId'],
                  url: gifticon['url'],
                  name: gifticon['name'],
                  store: gifticon['store'],
                  endDate: gifticon['endDate'],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
