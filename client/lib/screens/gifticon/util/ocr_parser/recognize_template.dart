import 'package:client/screens/gifticon/util/ocr_parser/templates/kakao_template.dart';
import 'package:client/screens/gifticon/util/ocr_parser/parsers/kakao_ocr_parser.dart';

class RecognizeTemplate {
  /// OCR로 읽은 텍스트를 분석하여 해당하는 파서를 실행
  static void recognizeAndParse(String ocrText) {
    // 카카오톡 기프티콘 텍스트 확인
    if (KakaoTemplate.isKakaoGifticon(ocrText)) {
      KakaoOCRParser.parse(ocrText);
    } else {
      // 텍스트가 어떤 템플릿에도 속하지 않는 경우
      print("No template matched for the given OCR text.");
    }
  }
}
