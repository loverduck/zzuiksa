import 'package:client/screens/gifticon/model/gifticon_model.dart';
import 'package:intl/intl.dart';

int countExpiringGifticons(List<Gifticon> gifticons) {
  DateTime now = DateTime.now();
  final weekLater = now.add(Duration(days: 7));

  return gifticons.where((gifticon) {
    if (gifticon.isUsed != '미사용' && gifticon.isUsed != '사용중') {
      return false;
    }

    DateTime endDate;
    try {
      endDate = DateFormat('yyyy-MM-dd').parse(gifticon.endDate!);
    } catch (e) {
      print("Date parsing error: $e");
      return false;
    }

    return endDate.isBefore(weekLater) && !endDate.isBefore(now);
  }).length;
}
