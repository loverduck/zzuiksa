import 'package:client/screens/gifticon/model/gifticon_model.dart';
import 'package:flutter/material.dart';

import '../../util/status_stamp.dart';

class GifticonListItem extends StatelessWidget {
  final Map<String, dynamic> gifticon;

  const GifticonListItem({
    Key? key,
    required this.gifticon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String stampImage = getStatusStamp(gifticon as Gifticon);

    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/gifticon_detail_screen', arguments: gifticon['id']),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image(
              image: AssetImage(gifticon['url']),
              height: 100,
              width: 100,
              fit: BoxFit.fitWidth,
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
                gifticon['name'],
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
