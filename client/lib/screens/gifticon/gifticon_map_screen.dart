
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'model/gifticon_model.dart';

class GifticonMapScreen extends StatefulWidget {
  const GifticonMapScreen({
    super.key,
    required this.gifticonId,
  });

  final int gifticonId;

  @override
  State<GifticonMapScreen> createState() => _GifticonMapScreenState();
}

class _GifticonMapScreenState extends State<GifticonMapScreen> {
  Gifticon ? gifticon;

  @override
  void initState() {
    super.initState();
    // Mock data for testing
    gifticon = Gifticon(
        id: 1,
        name: '아이스아메리카노T',
        url: 'assets/images/tempGifticon.jpeg',
        store: '스타벅스',
        couponNum: '1234567890',
        endDate: '2024-05-31',
        isUsed: '미사용',
        remainMoney: 5000,
        memo: '커피 좋아!'
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),

    );
  }
}
