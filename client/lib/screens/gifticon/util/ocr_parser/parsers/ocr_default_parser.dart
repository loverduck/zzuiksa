import 'package:client/screens/gifticon/model/gifticon_model.dart';

class DefaultOCRParser {
  static Gifticon parse(String ocrText) {
    var gifticon = Gifticon();
    List<String> lines = ocrText.split('\n').map((line) => line.trim()).toList();

    for (var line in lines) {
      if (line.contains("교환처")) {
        gifticon.store = line.replaceAll(RegExp(r'교환처\s*:\s*'), '');
      } else if (line.contains("상품명")) {
        gifticon.name = line.replaceAll(RegExp(r'상품명\s*:\s*'), '');
        RegExp moneyRegex = RegExp(r'(\d[\d,]*)\s*원[권]*');
        var moneyMatch = moneyRegex.firstMatch(line);
        if (moneyMatch != null) {
          gifticon.remainMoney = int.parse(moneyMatch.group(1)!.replaceAll(',', ''));
        }
      } else if (line.contains("유효기간") || line.contains("까지")) {
        String dateText = line.replaceAll(RegExp(r'유효기간\s*:\s*'), '');
        RegExp dateRegex = RegExp(
            r'(\d{2}\.\d{2}\.\d{2})\s*~\s*(\d{2}\.\d{2}\.\d{2})');
        var dateMatch = dateRegex.firstMatch(dateText);
        if (dateMatch != null) {
          // '~' 뒤의 날짜 사용
          String endDate = dateMatch.group(2)!;
          String year = "20" + endDate.substring(0, 2);
          String month = endDate.substring(3, 5);
          String day = endDate.substring(6, 8);
          gifticon.endDate = "$year-$month-$day";
        } else {
          gifticon.endDate = dateText; // 패턴 매칭 실패시 원본 텍스트 사용
        }
        // } else if (line.replaceAll(RegExp(r'[^0-9\-]'), '').length == line.length) {
        //   gifticon.couponNum = line.replaceAll(RegExp(r'[^0-9]'), '');
        // }
      } else if (line.length >= 12) {
        if (RegExp(r'^[\d\s]+$').hasMatch(line)) {
          // 문자열이 숫자와 공백으로만 이루어져 있습니다.
          gifticon.couponNum = line.replaceAll(' ', ''); // 공백 제거
        } else if (RegExp(r'^[A-Z0-9\s]+$').hasMatch(line) &&
            RegExp(r'\d').hasMatch(line)) {
          // 문자열이 숫자, 대문자 알파벳, 공백으로 이루어져 있으며, 숫자가 최소 한 개 포함되어 있습니다.
          gifticon.couponNum = line.replaceAll(' ', ''); // 공백 제거
        }
      }
    }

    return gifticon;
  }
}
