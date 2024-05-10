import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BarcodeModal extends StatelessWidget {
  final String couponNum;

  const BarcodeModal({Key? key, required this.couponNum}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text('쿠폰 번호'),
      content: Column(
        children: [
          Text(
            couponNum,
            style: TextStyle(fontSize: 24),
          ),
        ],
      ),
      actions: [
        CupertinoDialogAction(
          child: Text('취소'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        CupertinoDialogAction(
          child: Text('확인'),
          onPressed: () {
            // 여기에 쿠폰 사용 로직 추가
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}