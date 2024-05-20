class gsnTemplate {
  static final List<String> keywords = [
    "GS&",
    "GS&쿠폰",
    "믿을 수 있는 기업전용 모바일쿠폰 서비스",
  ];

  static bool isGsnGifticon(String text) {
    String lowerText = text.toLowerCase();
    return keywords.any((keyword) => lowerText.contains(keyword.toLowerCase()));
  }
}