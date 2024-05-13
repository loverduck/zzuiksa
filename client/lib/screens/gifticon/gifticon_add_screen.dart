import 'package:client/screens/gifticon/service/gifticon_api.dart';
import 'package:client/screens/gifticon/service/merged_field.dart';
import 'package:client/screens/gifticon/util/ocr_parser/recognize_template.dart';
import 'package:client/screens/gifticon/util/ocr_sample_parser.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../constants.dart';

import 'gifticon_detail_screen.dart';
import 'model/gifticon_model.dart';
import 'widgets/gifticon_form.dart';

class GifticonAddScreen extends StatefulWidget {
  static const title = 'Gifticon';
  static const androidIcon = Icon(Icons.card_giftcard);
  static const iosIcon = Icon(CupertinoIcons.news);

  final List<MergedField> ocrFields;
  final String? selectedImagePath;

  const GifticonAddScreen({super.key, required this.ocrFields, this.selectedImagePath});

  @override
  State<GifticonAddScreen> createState() => _GifticonAddScreenState();
}

class _GifticonAddScreenState extends State<GifticonAddScreen> {

  late Gifticon _initialGifticon;

  @override
  void initState() {
    super.initState();
    String ocrText = widget.ocrFields.map((field) => field.text).join('\n');
    _initialGifticon = RecognizeTemplate.recognizeAndParse(ocrText);
  }

  void _navigateToDetailScreen(Gifticon gifticon) async {
    try {
      Gifticon createdGifticon = await postGifticon(gifticon);
      if (createdGifticon.id != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GifticonDetailScreen(gifticonId: createdGifticon.id),
          ),
        );
      } else {
        throw Exception('Failed to get gifticon ID.');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("기프티콘 등록에 실패했습니다. 다시 시도해 주세요. 오류: $e"),
            backgroundColor: Colors.red,
          )
      );
    }
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
              _navigateToDetailScreen(_initialGifticon);
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
      body: GifticonForm(
        onSubmit: _navigateToDetailScreen,
        initialGifticon: _initialGifticon,
        selectedImagePath: widget.selectedImagePath, // 이미지 경로를 GifticonForm에 전달
        isEdit: false,
      ),
    );
  }
}
