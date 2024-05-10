// kakao_template.dart, giftishow_templates.dart, sendbee_template.dart

/// 카카오톡 기프티콘을 인식하기 위한 키워드 목록
class KakaoTemplate {
  /// 기프티콘을 인식할 때 사용할 키워드 리스트
  static final List<String> keywords = [
    "kakaotalk",
    "선물하기",
  ];

  /// 해당 텍스트가 카카오톡 기프티콘 관련 텍스트인지 판별하는 함수
  static bool isKakaoGifticon(String text) {
    // 텍스트를 소문자로 변환하여 비교
    String lowerText = text.toLowerCase();
    // 키워드 리스트 중 하나라도 포함되어 있다면 true 반환
    return keywords.any((keyword) => lowerText.contains(keyword.toLowerCase()));
  }
}
