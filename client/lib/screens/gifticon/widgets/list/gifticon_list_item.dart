import 'package:client/screens/gifticon/model/gifticon_model.dart';
import 'package:client/screens/gifticon/model/gifticon_preview_model.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import '../../../../utils/image_utils.dart';
import '../../util/status_stamp.dart';

class GifticonListItem extends StatefulWidget {
  final GifticonPreview gifticonPreview;

  const GifticonListItem({
    Key? key,
    required this.gifticonPreview,
  }) : super(key: key);

  @override
  _GifticonListItemState createState() => _GifticonListItemState();
}

class _GifticonListItemState extends State<GifticonListItem> {
  Future<Widget> _loadImage() async {
    if (widget.gifticonPreview.url != null) {
      try {
        File imageFile = await ImageUtils.loadImage(widget.gifticonPreview.url!);
        return Image.file(
          imageFile,
          height: 120,
          width: 120,
          fit: BoxFit.cover,
        );
      } catch (e) {
        print("Failed to load image: $e");
        return SizedBox.shrink(); // 이미지 로딩 실패 시 빈 위젯 반환
      }
    } else {
      return Text('이미지 URL이 없습니다.');
    }
  }

  @override
  Widget build(BuildContext context) {
    String stampImage = getStatusStamp(widget.gifticonPreview);

    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/gifticon/detail', arguments: {"gifticonId": widget.gifticonPreview.gifticonId}),
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
                right: 10, // 스탬프 위치 조절
                child: Image.asset(
                  stampImage,
                  height: 60, // 스탬프 크기 조절
                  fit: BoxFit.cover,
                ),
              ),
            Positioned(
              bottom: 8,
              child: Text(
                widget.gifticonPreview.name!,
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
