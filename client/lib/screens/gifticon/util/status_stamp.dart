import 'package:client/screens/gifticon/model/gifticon_preview_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../model/gifticon_model.dart';

String getStatusStamp(GifticonPreview gifticon) {
  DateTime now = DateTime.now();
  DateTime endDate = DateFormat('yyyy-MM-dd').parse(gifticon.endDate!);

  if (gifticon.isUsed == '사용완료') {
    return 'assets/stamps/used_stamp.png';
  } else if ((gifticon.isUsed == '미사용' || gifticon.isUsed == '사용중') && endDate.isBefore(now)) {
    return 'assets/stamps/expired_stamp.png';
  } else if (gifticon.isUsed == '사용중' && gifticon.remainMoney != null && gifticon.remainMoney! > 0) {
    return 'assets/stamps/in_use_stamp.png';
  }

  return ''; // 도장이 필요 없는 경우
}
