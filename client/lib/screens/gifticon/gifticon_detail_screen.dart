import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GifticonDetailScreen extends StatefulWidget {
  static const title = 'Gifticon';
  static const androidIcon = Icon(Icons.card_giftcard);
  static const iosIcon = Icon(CupertinoIcons.news);

  const GifticonDetailScreen({super.key});

  @override
  State<GifticonDetailScreen> createState() => _GifticonDetailScreenState();
}

class _GifticonDetailScreenState extends State<GifticonDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(
            'GifticonDetail Page'
        )
    );
  }
}
