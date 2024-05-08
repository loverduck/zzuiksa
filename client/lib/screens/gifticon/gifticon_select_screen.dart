import 'dart:convert';
import 'dart:io';

import 'package:client/screens/gifticon/service/merged_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../constants.dart';
import 'model/gifticon_ocr_request_model.dart';
import 'model/gifticon_ocr_response_model.dart';
import 'service/gifticon_ocr_api.dart';

class GifticonSelectScreen extends StatefulWidget {
  static const title = 'Gifticon';
  static const androidIcon = Icon(Icons.card_giftcard);
  static const iosIcon = Icon(CupertinoIcons.news);

  const GifticonSelectScreen({super.key});

  @override
  State<GifticonSelectScreen> createState() => _GifticonSelectScreenState();
}

class _GifticonSelectScreenState extends State<GifticonSelectScreen> {
  String? _selectedImagePath;
  List<MergedField> _ocrResults = [];
  final _ocrApi = GifticonOcrApi();

  Future<void> _pickImage() async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _selectedImagePath = pickedImage.path;
      });

      final model = GifticonOcrRequestModel(
        images: [
          ImageData(
            format: pickedImage.path.split('.').last,
            name: "medium",
            url: null,
            data: base64Encode(await pickedImage.readAsBytes()),
          ),
        ],
        requestId: "unique_request_id",
        resultType: "string",
        timestamp: DateTime.now().millisecondsSinceEpoch,
      );

      try {
        final result = await _ocrApi.requestOcr(model);
        final response = GifticonOcrResponseModel.fromJson(result);
        setState(() {
          _ocrResults = response.mergedFields;
        });
      } catch (e) {
        print("OCR request failed: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('이미지 선택', style: textTheme.displayLarge),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Constants.main200,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, '/gifticon_add_screen');
            },
            child: Text(
              '다음',
              style: TextStyle(
                fontSize: 24,
                color: Constants.textColor,
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _pickImage,
              child: const Text('Select Image'),
            ),
            const SizedBox(height: 20),
            if (_selectedImagePath != null)
              Image.file(
                File(_selectedImagePath!),
                height: 200,
              ),
            const SizedBox(height: 20),
            ..._ocrResults.map((field) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                children: [
                  Text(
                    'Text: ${field.text}',
                    style: textTheme.bodyMedium,
                  ),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}
