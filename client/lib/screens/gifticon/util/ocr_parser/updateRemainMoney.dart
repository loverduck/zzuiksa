import '../../model/gifticon_model.dart';

void updateRemainMoney(Gifticon gifticon) {
  if (gifticon.name == null) return;

  RegExp regex = RegExp(r'(\d+)(천원|만원|원|권)');
  var matches = regex.allMatches(gifticon.name!);

  for (var match in matches) {
    if (match.group(0)!.contains("천원")) {
      int value = int.parse(match.group(1)!) * 1000;
      gifticon.remainMoney = value;
    } else if (match.group(0)!.contains("만원")) {
      int value = int.parse(match.group(1)!) * 10000;
      gifticon.remainMoney = value;
    } else if (match.group(0)!.contains("원") || match.group(0)!.contains("권")) {
      int value = int.parse(match.group(1)!);
      gifticon.remainMoney = value;
    }
  }
}
