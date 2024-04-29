import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../constants.dart';

import 'gifticon_detail_screen.dart';
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
  void _navigateToDetailScreen(Map<String, dynamic> formData) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GifticonDetailScreen(data: formData),
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
              Navigator.pushNamed(context, '/gifticon_detail_screen');
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
