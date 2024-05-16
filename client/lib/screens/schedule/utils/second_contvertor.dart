String secondsConvertor(int seconds) {
  int hours = seconds ~/ 3600; // 전체 시간(시)을 계산합니다.
  int minutes = (seconds % 3600) ~/ 60; // 남은 초를 이용해 분을 계산합니다.

  if (hours == 0) {
    return "$minutes분";
  }

  return "$hours시간 $minutes분";
}
