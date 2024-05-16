import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:barcode_widget/barcode_widget.dart';

class BarcodeModal extends StatelessWidget {
  final String couponNum;

  const BarcodeModal({Key? key, required this.couponNum}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text('쿠폰 번호'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            couponNum,
            style: TextStyle(fontSize: 24),
          ),
          SizedBox(height: 20),
          BarcodeWidget(
            barcode: Barcode.code128(),
            data: couponNum,
            width: 200,
            height: 80,
            drawText: false,
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
            //쿠폰 사용 로직 추가...
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
