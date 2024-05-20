import 'package:client/screens/gifticon/model/gifticon_model.dart';

import '../updateRemainMoney.dart';

class SendBOCRParser {
  static Gifticon parse(String ocrText) {
    Gifticon gifticon = Gifticon();
    List<String> lines = ocrText.split('\n').map((line) => line.trim()).toList();

    for (int i = 0; i < lines.length; i++) {
      String line = lines[i];

      if (line.contains('까지')) {
        String endDate = line.split('까지')[0].trim();
        if (endDate.startsWith('사용기간: ')) {
          endDate = endDate.substring('사용기간: '.length).trim();
        }
        gifticon.endDate = endDate;

        if (i > 0) {
          String previousLine = lines[i - 1];
          int bracketIndex = previousLine.indexOf(']');
          if (bracketIndex != -1) {
            gifticon.store = previousLine.substring(1, bracketIndex).trim();
            gifticon.name = previousLine.substring(bracketIndex + 1).trim();
            updateRemainMoney(gifticon);
          }
        }
      } else if (RegExp(r'^[\d\s]+$').hasMatch(line)) {
        String potentialBarcode = line.replaceAll(RegExp(r'[^0-9]'), '');
        if (potentialBarcode.length >= 10) {
          gifticon.couponNum = potentialBarcode;
        }
      }
    }

    // 체크하고 '상품명: ' 뒤의 내용으로 name을 갱신
    if (gifticon.name!.endsWith('···')) {
      bool foundReplacement = false;
      for (String line in lines) {
        if (line.startsWith('상품명 : ')) {
          gifticon.name = line.replaceFirst('상품명 : ', '').trim();
          updateRemainMoney(gifticon);
          foundReplacement = true;
          break;
        }
      }
      if (!foundReplacement) {
        print("No full product name found in the document to replace ellipsis.");
      }
    }

    return gifticon;
  }
}
