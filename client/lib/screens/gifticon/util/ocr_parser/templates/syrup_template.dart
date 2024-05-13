class syrupTemplate {
  static final List<String> keywords = [
    "gifticon",
    "마음을 전합니다",
    "마음을 전하는 또 다른 방법",
    "기프티콘"
  ];

  static bool isSyrupGifticon(String text) {
    String lowerText = text.toLowerCase();
    return keywords.any((keyword) => lowerText.contains(keyword.toLowerCase()));
  }
}