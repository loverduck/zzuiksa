import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../constants.dart';
import 'model/gifticon_model.dart';
import 'gifticon_detail_screen.dart';
import 'widgets/gifticon_add_form.dart';

class GifticonUpdateScreen extends StatefulWidget {
  final Gifticon gifticon;

  static const androidIcon = Icon(Icons.card_giftcard);
  static const iosIcon = Icon(CupertinoIcons.news);

  const GifticonUpdateScreen({
    super.key,
    required this.gifticon
  });

  @override
  State<GifticonUpdateScreen> createState() => _GifticonUpdateScreenState();
}

class _GifticonUpdateScreenState extends State<GifticonUpdateScreen> {
  late Gifticon gifticon;

  @override
  void initState() {
    super.initState();
    gifticon = widget.gifticon;
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
              // Update gifticon using API or whatever necessary
            },
            child: Text(
              '수정하기',
              style: TextStyle(
                fontSize: 24,
                color: Constants.textColor,
              ),
            ),
          ),
        ],
      ),
      body: GifticonAddForm(
        initialGifticon: gifticon,
        onSubmit: (updatedGifticon) {
          gifticon = updatedGifticon;
        },
      ),
    );
  }
}
