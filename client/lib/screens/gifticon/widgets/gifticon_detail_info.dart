import 'package:flutter/material.dart';
import 'package:client/screens/gifticon/model/gifticon_model.dart';
import 'package:client/styles.dart';

class GifticonDetailInfo extends StatelessWidget {
  final Gifticon gifticon;

  const GifticonDetailInfo({
    Key? key,
    required this.gifticon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    gifticon.store ?? 'N/A',
                    style: myTheme.textTheme.displayMedium,
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  // 바코드 및 쿠폰 번호 뜨는 화면으로 이동
                },
                child: Text('사용하기', style: myTheme.textTheme.displayMedium),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            gifticon.name ?? 'N/A',
            style: myTheme.textTheme.displayMedium,
          ),
          SizedBox(height: 8),
          Text('${gifticon.endDate ?? 'N/A'} 까지',
              style: myTheme.textTheme.displayMedium),
          SizedBox(height: 16),
          TextField(
            decoration: InputDecoration(
              labelText: '메모',
              border: OutlineInputBorder(),
            ),
            controller: TextEditingController(text: gifticon.memo ?? ''),
            readOnly: true,
          ),
          SizedBox(height: 10),
          Text(
            '사용 가능한 주변 지점',
            style: myTheme.textTheme.displayMedium,
          ),
          ElevatedButton.icon(
            onPressed: () {
              //지도 화면으로 이동하는 내용 추가
            },
            icon: Icon(Icons.map),
            label: Text('지도로 보기', style: myTheme.textTheme.displayMedium),
          ),
          ...List.generate(3, (index) => _buildNearbyStoreInfo(gifticon)),
        ],
      ),
    );
  }

  Widget _buildNearbyStoreInfo(Gifticon gifticon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(Icons.place, color: Colors.grey),
              SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    gifticon.store ?? 'N/A',
                    style: myTheme.textTheme.displayMedium,
                  ),
                  Text(
                    '서울 강남구 테헤란로29길 10',
                    style: myTheme.textTheme.displayMedium,
                  ),
                ],
              ),
            ],
          ),
          Text(
            '65m',
            style: myTheme.textTheme.displayMedium,
          ),
        ],
      ),
    );
  }
}
