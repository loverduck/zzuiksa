import 'package:client/screens/gifticon/service/gifticon_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../constants.dart';

import 'gifticon_detail_screen.dart';
import 'model/gifticon_model.dart';
import 'widgets/gifticon_add_form.dart';

class GifticonAddScreen extends StatefulWidget {
  static const title = 'Gifticon';
  static const androidIcon = Icon(Icons.card_giftcard);
  static const iosIcon = Icon(CupertinoIcons.news);

  const GifticonAddScreen({super.key});

  @override
  State<GifticonAddScreen> createState() => _GifticonAddScreenState();
}

class _GifticonAddScreenState extends State<GifticonAddScreen> {
  void _navigateToDetailScreen(Gifticon createdGifticon) {
    if (createdGifticon.id == null) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("기프티콘 등록에 실패했습니다. 다시 시도해 주세요."),
            backgroundColor: Colors.red,
          )
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        // builder: (context) => GifticonDetailScreen(gifticonId: createdGifticon.id!),
        builder: (context) => GifticonDetailScreen(gifticonId: 1),
      ),
    );
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
        backgroundColor: Constants.main200,
        actions: [
          TextButton(
            onPressed: () {
              // Gifticon newGifticon = Gifticon(name: "새 기프티콘");
              // postGifticon(newGifticon).then((createdGifticon) {
              //   _navigateToDetailScreen(createdGifticon);
              // });
              Navigator.pushNamed(context, '/gifticon_detail_screen', arguments: 1);
            },
            child: Text(
              '등록하기',
              style: TextStyle(
                fontSize: 24,
                color: Constants.textColor,
              ),
            ),
          ),
        ],
      ),
      body: GifticonAddForm(onSubmit: _navigateToDetailScreen),
    );
  }
}
