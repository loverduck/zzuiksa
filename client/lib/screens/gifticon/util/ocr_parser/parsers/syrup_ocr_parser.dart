import 'package:client/screens/gifticon/model/gifticon_model.dart';

import '../updateRemainMoney.dart';

class SyrupOCRParser {
  static Gifticon parse(List<dynamic> fields) {
    Gifticon gifticon = Gifticon();
    int expectedX = 126; // X 좌표 최대값 설정

    // 텍스트 필드 위치 정보에 따라 필터링
    for (var field in fields) {
      var text = field['inferText'];
      var xCoordinate = getXCoordinateFromField(field);

      if (xCoordinate > expectedX) continue;  // 설정된 X 좌표보다 큰 경우 무시

      if (text.contains("기프티콘명")) {
        gifticon.name = extractTextAfterKeyword(text, "기프티콘명");
        updateRemainMoney(gifticon);
      } else if (text.contains("사용기한")) {
        String dateStr = extractTextAfterKeyword(text, "사용기한");
        gifticon.endDate = formatDate(dateStr);
      } else if (text.contains("사용처")) {
        gifticon.store = extractTextAfterKeyword(text, "사용처");
      } else if (RegExp(r'^[\d\s]+$').hasMatch(text)) {
        gifticon.couponNum = text.replaceAll(RegExp(r'[^0-9]'), '');
      }
    }

    return gifticon;
  }

  static int getXCoordinateFromField(dynamic field) {
    // 바운딩 폴리의 첫 번째 버텍스 X 좌표 추출
    return field['boundingPoly']['vertices'][0]['x'];
  }

  static String extractTextAfterKeyword(String text, String keyword) {
    // 키워드 이후 텍스트 추출
    int startIndex = text.indexOf(keyword) + keyword.length;
    return text.substring(startIndex).trim();
  }

  static String formatDate(String dateStr) {
    // 날짜 포매팅 로직
    RegExp exp = RegExp(r'(\d{4})/(\d{1,2})/(\d{1,2})');
    Match? match = exp.firstMatch(dateStr);
    if (match != null) {
      String year = match.group(1)!;
      String month = match.group(2)!.padLeft(2, '0');
      String day = match.group(3)!.padLeft(2, '0');
      return '$year-$month-$day';
    }
    return '';
  }
}
