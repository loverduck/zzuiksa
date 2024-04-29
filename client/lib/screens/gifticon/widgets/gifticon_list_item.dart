import 'package:flutter/material.dart';

class GifticonListItem extends StatelessWidget {
  final String gifticonId;
  final String url;
  final String name;
  final String store;
  final String endDate;

  const GifticonListItem({
    Key? key,
    required this.gifticonId,
    required this.url,
    required this.name,
    required this.store,
    required this.endDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.asset(url),
      title: Text(name),
      subtitle: Text('브랜드: $store, 사용 기한: $endDate'),
      onTap: () => Navigator.pushNamed(context, '/gifticon_detail_screen'),
    );
  }
}
