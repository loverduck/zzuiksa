import 'package:client/screens/gifticon/model/gifticon_model.dart';

import '../updateRemainMoney.dart';

class KakaoOCRParser {
  static Gifticon parse(String ocrText) {
    Gifticon gifticon = Gifticon();
    List<String> lines = ocrText.split('\n').map((line) => line.trim()).toList();
    int barcodeIndex = -1;  // 바코드 위치를 저장할 변수 초기화

    for (int i = 0; i < lines.length; i++) {
      String line = lines[i];

      if (line.contains('교환처')) {
        gifticon.store = line.replaceAll('교환처 ', '').trim();
      } else if (line.contains('유효기간')) {
        String dateText = line.replaceAll('유효기간 ', '').replaceAll('년 ', '-').replaceAll('월 ', '-').replaceAll('일', '').trim();
        gifticon.endDate = dateText;
      } else if (RegExp(r'^[\d\s]+$').hasMatch(line)) {
        String potentialBarcode = line.replaceAll(RegExp(r'[^0-9]'), '');
        if (potentialBarcode.length >= 10) {
          gifticon.couponNum = potentialBarcode;
          barcodeIndex = i;  // 바코드 위치 저장
          if (i > 0) {
            gifticon.name = lines[i - 1].trim();
            updateRemainMoney(gifticon);
          }
        }
      }
    }

    // 모든 줄을 처리한 후에 store가 비어있으면 바코드 2줄 위에 있는 라인을 store로 설정
    if (gifticon.store == null || gifticon.store!.isEmpty) {
      if (barcodeIndex > 1) {  // 바코드 2줄 위가 존재하는지 확인
        gifticon.store = lines[barcodeIndex - 2].trim();
      }
    }

    return gifticon;
  }
}
