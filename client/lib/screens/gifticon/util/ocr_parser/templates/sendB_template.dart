class sendBTemplate {
  static final List<String> keywords = [
    "Send[B]",
    "Send",
  ];

  static bool isSendBGifticon(String text) {
    String lowerText = text.toLowerCase();
    return keywords.any((keyword) => lowerText.contains(keyword.toLowerCase()));
  }
}