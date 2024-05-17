import 'package:client/screens/gifticon/model/gifticon_model.dart';
import 'package:client/screens/gifticon/model/gifticon_preview_model.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import '../../../../utils/image_utils.dart';
import '../../util/status_stamp.dart';

class GifticonListItem extends StatelessWidget {
  final GifticonPreview gifticonPreview;

  const GifticonListItem({
    Key? key,
    required this.gifticonPreview,
  }) : super(key: key);

  Future<Widget> _loadImage() async {
    if (gifticonPreview?.url != null) {
      try {
        File imageFile = await ImageUtils.loadImage(gifticonPreview!.url!);
        return Image.file(
          imageFile,
          height: 150,
          width: 150,
          fit: BoxFit.cover,
        );
      } catch (e) {
        print("Failed to load image: $e");
        return SizedBox.shrink(); // 이미지 로딩 실패 시 빈 위젯 반환
      }
    } else {
      return SizedBox.shrink(); // url이 없는 경우 빈 위젯 반환
    }
  }

  @override
  Widget build(BuildContext context) {
    String stampImage = getStatusStamp(gifticonPreview);

    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/gifticon/detail', arguments: {"gifticonId":gifticonPreview.gifticonId}),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          alignment: Alignment.center,
          children: [
            FutureBuilder<Widget>(
              future: _loadImage(),
              builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('이미지 로딩 실패: ${snapshot.error}');
                } else {
                  return snapshot.data ?? SizedBox.shrink();
                }
              },
            ),
            if (stampImage.isNotEmpty)
              Positioned(
                top: 10,
                child: Image.asset(
                  stampImage,
                  height: 50,
                  fit: BoxFit.cover,
                ),
              ),
            Positioned(
              bottom: 8,
              child: Text(
                gifticonPreview!.name!,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontSize: 14, // 이름 폰트 사이즈 조절
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
