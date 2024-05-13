import 'package:client/screens/gifticon/model/gifticon_model.dart';

class KakaoOCRParser {
  static Gifticon parse(String ocrText) {
    Gifticon gifticon = Gifticon();
    List<String> lines = ocrText.split('\n');

    for (String line in lines) {
      line = line.trim();
      if (line.contains('교환처')) {
        gifticon.store = line.replaceAll('교환처 : ', '').trim();
      } else if (line.contains('상품명')) {
        gifticon.name = line.replaceAll('상품명 : ', '').trim();
      } else if (line.contains('유효기간')) {
        // 날짜 형식을 정규화 (예: 2024년 05월 31일 -> 2024-05-31)
        String dateText = line.replaceAll('유효기간 : ', '').replaceAll('년 ', '-').replaceAll('월 ', '-').replaceAll('일', '').trim();
        gifticon.endDate = dateText;
      } else {
        // 숫자만 있는 경우 바코드로 간주
        String potentialBarcode = line.replaceAll(RegExp(r'[^0-9]'), '');
        if (potentialBarcode.length >= 10) {  // 바코드 길이가 일반적으로 10자 이상
          gifticon.couponNum = potentialBarcode;
        }
      }
    }
    return gifticon;
  }
}
