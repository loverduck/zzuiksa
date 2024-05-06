import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../constants.dart';

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

  Future<void> _pickImage() async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _selectedImagePath = pickedImage.path;
      });
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
          icon: Icon(Icons.arrow_back),
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
              child: Text('Select Image'),
            ),
            SizedBox(height: 20),
            if (_selectedImagePath != null)
              Image.file(
                File(_selectedImagePath!),
                height: 200,
              ),
          ],
        ),
      ),
    );
  }
}
