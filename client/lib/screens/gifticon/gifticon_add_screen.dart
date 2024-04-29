import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GifticonAddScreen extends StatefulWidget {
  static const title = 'Gifticon';
  static const androidIcon = Icon(Icons.card_giftcard);
  static const iosIcon = Icon(CupertinoIcons.news);

  const GifticonAddScreen({super.key});

  @override
  State<GifticonAddScreen> createState() => _GifticonAddScreenState();
}

class _GifticonAddScreenState extends State<GifticonAddScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(
            'GifticonAdd Page'
        )
    );
  }
}
