// utils/my_utils.dart

/// 입력값 (정수형 4자리 문자열)을 포맷된 00:00 문자열로 변환
String formatTimeInput(String raw) {
  final padded = raw.padLeft(4, '0').substring(0, 4);
  final hours = padded.substring(0, 2);
  final minutes = padded.substring(2, 4);
  return "$hours:$minutes";
}

/// 입력값 (정수형 4자리 문자열)을 총 초(second) 단위로 변환
int convertToTotalSeconds(String raw) {
  final padded = raw.padLeft(4, '0').substring(0, 4);
  int hour = int.tryParse(padded.substring(0, 2)) ?? 0;
  int min = int.tryParse(padded.substring(2, 4)) ?? 0;

  if (min >= 60) {
    hour += min ~/ 60;
    min = min % 60;
  }

  return hour * 3600 + min * 60;
}

/// 총 초 → 00:00 문자열 포맷으로 변환 (UI 출력용)
String formatTimeFromSeconds(int seconds) {
  final h = (seconds ~/ 3600).toString().padLeft(2, '0');
  final m = ((seconds % 3600) ~/ 60).toString().padLeft(2, '0');
  return "$h:$m";
}
