import 'package:client/screens/gifticon/model/gifticon_model.dart';
import 'package:client/screens/gifticon/service/merged_field.dart';

Gifticon parseOcrResultsToGifticon(List<MergedField> fields) {
  var gifticon = Gifticon();

  for (var field in fields) {
    var text = field.text;
    if (text.contains("교환처")) {
      gifticon.store = text.replaceAll(RegExp(r'교환처\s*:\s*'), '');
    } else if (text.contains("상품명")) {
      gifticon.name = text.replaceAll(RegExp(r'상품명\s*:\s*'), '');
      // 금액 파싱 로직 추가
      RegExp moneyRegex = RegExp(r'(\d[\d,]*)\s*원[권]*');
      var moneyMatch = moneyRegex.firstMatch(text);
      if (moneyMatch != null) {
        gifticon.remainMoney = int.parse(moneyMatch.group(1)!.replaceAll(',', ''));
      }
    } else if (text.contains("유효기간") || text.contains("까지")) {
      gifticon.endDate = text.replaceAll(RegExp(r'유효기간\s*:\s*'), '');
    } else if (text.replaceAll(RegExp(r'[^0-9\-]'), '').length == text.length) {
      gifticon.couponNum = text.replaceAll(RegExp(r'[^0-9]'), '');  // 숫자만 추출
    }
  }

  return gifticon;
}
