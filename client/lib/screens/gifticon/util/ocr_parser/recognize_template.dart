import 'dart:convert';

import 'package:client/screens/gifticon/util/ocr_parser/parsers/ocr_default_parser.dart';
import 'package:client/screens/gifticon/util/ocr_parser/templates/sendB_template.dart';
import 'package:client/screens/gifticon/util/ocr_parser/parsers/sendB_ocr_parser.dart';
import 'package:client/screens/gifticon/util/ocr_parser/templates/gsn_template.dart';
import 'package:client/screens/gifticon/util/ocr_parser/parsers/gsn_ocr_parser.dart';
import 'package:client/screens/gifticon/util/ocr_parser/templates/kakao_template.dart';
import 'package:client/screens/gifticon/util/ocr_parser/parsers/kakao_ocr_parser.dart';
import 'package:client/screens/gifticon/util/ocr_parser/templates/syrup_template.dart';
import 'package:client/screens/gifticon/util/ocr_parser/parsers/syrup_ocr_parser.dart';


import '../../model/gifticon_model.dart';

class RecognizeTemplate {
  /// OCR로 읽은 텍스트를 분석하여 해당하는 파서를 실행
  static Gifticon recognizeAndParse(String ocrText) {
    // String ocrText = json['text'];  // 가정된 OCR 전체 텍스트
    // var fields = json['fields'];  // 가정된 필드 데이터

    // 카카오톡 기프티콘 텍스트 확인
    if (KakaoTemplate.isKakaoGifticon(ocrText)) {
      return KakaoOCRParser.parse(ocrText);
    } else if (sendBTemplate.isSendBGifticon(ocrText)){
      return SendBOCRParser.parse(ocrText);
    } else if (gsnTemplate.isGsnGifticon(ocrText)) {
      return gsnOCRParser.parse(ocrText);
      // } else if (syrupTemplate.isSyrupGifticon(ocrText)) {
      //   return SyrupOCRParser.parse(fields);  // 필드 데이터를 파서에 전달
    } else {
      print("No template matched for the given OCR text.");
      return DefaultOCRParser.parse(ocrText);
    }
  }
}
