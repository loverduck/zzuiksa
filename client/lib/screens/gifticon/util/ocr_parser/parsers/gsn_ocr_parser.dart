import 'package:client/screens/gifticon/model/gifticon_model.dart';

import '../updateRemainMoney.dart';

class gsnOCRParser {
  static Gifticon parse(String ocrText) {
    Gifticon gifticon = Gifticon();
    List<String> lines = ocrText.split('\n').map((line) => line.trim()).toList();

    int endDateIndex = lines.indexWhere((line) => line.contains('유효기간'));
    if (endDateIndex > 0) {
      // "유효기간" 윗줄에 오는 줄들을 합쳐서 name으로 설정
      gifticon.name = lines.sublist(0, endDateIndex).join('');
      updateRemainMoney(gifticon);

      if (endDateIndex + 1 < lines.length) {
        String endDateLine = lines[endDateIndex + 1];
        if (endDateLine.contains('까지')) {
          String rawDate = endDateLine.split('까지')[0].trim();
          // 날짜 형식 변환 로직
          gifticon.endDate = formatDate(rawDate);
        }
      }
    }

    // "사용처" 바로 밑에 오는 줄 처리
    int storeIndex = lines.indexWhere((line) => line.contains('사용처'));
    if (storeIndex + 1 < lines.length) {
      gifticon.store = lines[storeIndex + 1];
    }

    // 숫자 또는 '-'로만 이루어진 줄 찾기
    for (String line in lines) {
      if (RegExp(r'^[\d\-]+$').hasMatch(line)) {
        String potentialBarcode = line.replaceAll('-', '');
        if (potentialBarcode.length >= 10) {
          gifticon.couponNum = potentialBarcode;
        }
      }
    }

    return gifticon;
  }

  static String formatDate(String dateStr) {
    RegExp exp = RegExp(r'(\d{4})/(\d{1,2})/(\d{1,2})');
    Match? match = exp.firstMatch(dateStr);
    if (match != null) {
      String year = match.group(1)!;
      String month = match.group(2)!.padLeft(2, '0');  // 월을 두 자리로 포매팅
      String day = match.group(3)!.padLeft(2, '0');    // 일을 두 자리로 포매팅
      return '$year-$month-$day';
    }
    return '';  // 날짜 형식이 맞지 않을 경우 빈 문자열 반환
  }
}