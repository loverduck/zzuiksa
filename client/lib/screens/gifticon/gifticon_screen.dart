import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GifticonScreen extends StatefulWidget {
  static const title = 'Gifticon';
  static const androidIcon = Icon(Icons.card_giftcard);
  static const iosIcon = Icon(CupertinoIcons.news);

  const GifticonScreen({super.key});

  @override
  State<GifticonScreen> createState() => _GifticonScreenState();
}

class _GifticonScreenState extends State<GifticonScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(GifticonScreen.title)),
      body: Center(child: Text('Gifticon Page')),
    );
  }
}
