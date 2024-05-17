// import 'package:client/screens/gifticon/widgets/detail/use_button.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:client/screens/gifticon/model/gifticon_model.dart';
// import 'package:client/screens/gifticon/widgets/detail/gifticon_barcode_modal.dart';
// import 'package:client/styles.dart';
//
// import 'gifticon_store_map_button.dart';
//
//
// class GifticonDetailInfo extends StatelessWidget {
//   final Gifticon gifticon;
//
//   const GifticonDetailInfo({
//     Key? key,
//     required this.gifticon,
//   }) : super(key: key);
//
//   void _showBarcodeModal(BuildContext context, String couponNum) {
//     showCupertinoDialog(
//       context: context,
//       builder: (context) => BarcodeModal(couponNum: couponNum),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 gifticon.store ?? 'N/A',
//                 style: myTheme.textTheme.displayMedium,
//               ),
//               UseButton(
//                 onPressed: () => _showBarcodeModal(context, gifticon.couponNum ?? 'N/A'),
//               ),
//             ],
//           ),
//           const SizedBox(height: 8),
//           Text(
//             gifticon.name ?? 'N/A',
//             style: myTheme.textTheme.displayLarge,
//           ),
//           Text(
//             '${gifticon.endDate ?? 'N/A'} 까지',
//             style: myTheme.textTheme.displayMedium,
//           ),
//           const SizedBox(height: 16),
//           TextField(
//             decoration: const InputDecoration(
//               labelText: '메모',
//               border: OutlineInputBorder(),
//             ),
//             controller: TextEditingController(text: gifticon.memo ?? ''),
//             readOnly: true,
//           ),
//           // const SizedBox(height: 10),
//           // Row(
//           //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           //   children: [
//           //     Text(
//           //       '사용 가능한 주변 지점',
//           //       style: myTheme.textTheme.displayMedium,
//           //     ),
//           //     GifticonStoreMapButton(
//           //       onPressed: () => Navigator.pushNamed(context, '/gifticon_map_screen', arguments: gifticon.gifticonId),
//           //     )
//           //   ],
//           // ),
//           // const SizedBox(height: 8),
//           // ...List.generate(3, (index) => _buildNearbyStoreInfo(gifticon)),
//         ],
//       ),
//     );
//   }
//
//
//
//   Widget _buildNearbyStoreInfo(Gifticon gifticon) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 4.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Row(
//             children: [
//               const Icon(Icons.place, color: Colors.grey),
//               const SizedBox(width: 8),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     gifticon.store ?? 'N/A',
//                     style: myTheme.textTheme.displayMedium,
//                   ),
//                   Text(
//                     '서울 강남구 테헤란로29길 10',
//                     style: myTheme.textTheme.displayMedium,
//                   ),
//                 ],
//               ),
//             ],
//           ),
//           Text(
//             '65m',
//             style: myTheme.textTheme.displayMedium,
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:client/constants.dart';
import 'package:client/screens/gifticon/widgets/detail/use_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:client/screens/gifticon/model/gifticon_model.dart';
import 'package:client/screens/gifticon/widgets/detail/gifticon_barcode_modal.dart';
import 'package:client/styles.dart';
import 'package:intl/intl.dart';

class GifticonDetailInfo extends StatelessWidget {
  final Gifticon gifticon;

  const GifticonDetailInfo({
    Key? key,
    required this.gifticon,
  }) : super(key: key);

  void _showBarcodeModal(BuildContext context, String couponNum) {
    showCupertinoDialog(
      context: context,
      builder: (context) => BarcodeModal(couponNum: couponNum),
    );
  }

  @override
  Widget build(BuildContext context) {
    final endDate = gifticon.endDate;
    final DateTime? endDateParsed = endDate != null ? DateTime.tryParse(endDate) : null;
    final int daysLeft = endDateParsed != null ? endDateParsed.difference(DateTime.now()).inDays : 0;
    final String daysLeftText = daysLeft >= 0 ? "D - $daysLeft" : "사용 기한이 지난 기프티콘입니다.";

    TextStyle dDayStyle = TextStyle(
      fontSize: 25,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    );

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  gifticon.store ?? '사용처를 설정해보세요!',
                  style: myTheme.textTheme.displayMedium,
                ),
              ),
              Container(
                color: Constants.pink400,
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                margin: const EdgeInsets.only(top: 4, bottom: 16),
                child: Text(
                  daysLeftText,
                  style: dDayStyle,
                ),
              ),
            ],
          ),
          Text(
            gifticon.name ?? '기프티콘명을 설정해보세요!',
            style: myTheme.textTheme.displayLarge?.copyWith(fontSize: 38),
          ),
          Text(
            '${gifticon.endDate ?? 'N/A'} 까지 써야 해요!',
            style: myTheme.textTheme.displayMedium,
          ),

          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              border: Border.all(color: Constants.main600),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              gifticon.memo ?? '작성한 메모가 없습니다.',
              style: TextStyle(fontSize: 24, color: gifticon.memo?.isEmpty ?? true ? Colors.grey : Colors.black),
            ),
          ),
          const SizedBox(height: 16),
          Center( // UseButton을 가운데 정렬
            child: UseButton(
              onPressed: () => _showBarcodeModal(context, gifticon.couponNum ?? 'N/A'),
            ),
          ),
        ],
      ),
    );
  }
}