import 'package:client/screens/gifticon/model/gifticon_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:barcode_widget/barcode_widget.dart';

import '../../service/gifticon_api.dart';

class BarcodeModal extends StatefulWidget {
  final Gifticon gifticon;

  // const BarcodeModal({Key? key, required this.couponNum, this.remainMoney}) : super(key: key);
  const BarcodeModal({Key? key, required this.gifticon}) : super(key: key);

  @override
  _BarcodeModalState createState() => _BarcodeModalState();
}

class _BarcodeModalState extends State<BarcodeModal> {
  final TextEditingController _amountController = TextEditingController();
  int? remainingMoney;

  @override
  void initState() {
    super.initState();
    remainingMoney = widget.gifticon.remainMoney;
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  void _completeUsage() async {
    if (widget.gifticon.remainMoney != null) {
      // 금액권인 경우 처리
      final int inputAmount = int.tryParse(_amountController.text) ?? 0;
      int finalAmountUsed = inputAmount;

      if (inputAmount > widget.gifticon.remainMoney!) {
        finalAmountUsed = widget.gifticon.remainMoney!; // 입력 금액을 remainMoney에 맞춤
      }

      int newRemaining = widget.gifticon.remainMoney! - finalAmountUsed;
      widget.gifticon.remainMoney = newRemaining >= 0 ? newRemaining : 0;
      widget.gifticon.isUsed = widget.gifticon.remainMoney! > 0 ? 'INUSE' : 'USED';
    } else {
      widget.gifticon.isUsed = 'USED';
    }

    int res = await patchGifticon(widget.gifticon.gifticonId!, widget.gifticon);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("기프티콘 정보가 성공적으로 수정되었습니다."),
    ));
    Navigator.of(context).pop();  // 모달 창 닫기
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 20),
            BarcodeWidget(
              barcode: Barcode.code128(),
              data: widget.gifticon.couponNum ?? 'N/A',
              width: 200,
              height: 80,
              drawText: false,
            ),
            SizedBox(height: 10),
            Text(
              widget.gifticon.couponNum ?? 'N/A',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            if (remainingMoney != null) ...[
              Text(
                '남은 금액: ${widget.gifticon.remainMoney} 원',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _amountController,
                decoration: InputDecoration(
                  labelText: '사용한 금액',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  final int? usedAmount = int.tryParse(value);
                  if (usedAmount != null) {
                    setState(() {
                      if (usedAmount <= widget.gifticon.remainMoney!) {
                        int calculatedRemaining = widget.gifticon.remainMoney! - usedAmount;
                        remainingMoney = calculatedRemaining >= 0 ? calculatedRemaining : 0;
                      } else {
                        remainingMoney = 0; // If the input used amount is greater than the available amount
                      }
                    });
                  }
                },
              ),
              SizedBox(height: 10),
              Text(
                '사용 후 금액:  ${remainingMoney ?? widget.gifticon.remainMoney}  원',
                style: TextStyle(fontSize: 18),
              ),
            ],
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  child: Text('돌아가기'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: Text('사용 완료'),
                  onPressed: _completeUsage,  // 함수 직접 호출 대신 참조
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
//
//   bool _validateAmount() {
//     final amount = int.tryParse(_amountController.text);
//     return amount != null && amount <= widget.gifticon.remainMoney!;
//   }
//
//   Future<void> _patchGifticon(Gifticon nowGifticon) async {
//     if (widget.gifticon.remainMoney != null ) {
//       widget.gifticon.remainMoney = remainingMoney;
//       widget.gifticon.isUsed = remainingMoney! > 0 ? 'INUSE' : 'USED';
//     } else {
//       widget.gifticon.isUsed = 'USED';
//     }
//
//     int res = await patchGifticon(widget.gifticon.gifticonId!, widget.gifticon);
//     print('기프티콘 정보가 업데이트되었습니다.');
//   }
}
