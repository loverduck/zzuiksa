import 'package:flutter/material.dart';

class GifticonListItem extends StatelessWidget {
  final Map<String, dynamic> gifticon;

  const GifticonListItem({
    Key? key,
    required this.gifticon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/gifticon_detail_screen', arguments: gifticon['id']),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: Image(
                image: AssetImage(gifticon['url']),
                height: 80,
                width: 80,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              gifticon['name'],
              style: Theme.of(context).textTheme.subtitle1?.copyWith(
                fontSize: 20, // 이름 폰트 사이즈 조절
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
