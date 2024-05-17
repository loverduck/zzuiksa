import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:barcode_widget/barcode_widget.dart';

class BarcodeModal extends StatefulWidget {
  final String couponNum;
  final int? remainMoney;

  const BarcodeModal({Key? key, required this.couponNum, this.remainMoney}) : super(key: key);

  @override
  _BarcodeModalState createState() => _BarcodeModalState();
}

class _BarcodeModalState extends State<BarcodeModal> {
  final TextEditingController _amountController = TextEditingController();

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
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
              data: widget.couponNum,
              width: 200,
              height: 80,
              drawText: false,
            ),
            SizedBox(height: 10),
            Text(
              widget.couponNum,
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            if (widget.remainMoney != null) ...[
              Text(
                '남은 금액: ${widget.remainMoney} 원',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _amountController,
                decoration: InputDecoration(
                  labelText: '사용한 금액',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || int.tryParse(value) == null || int.parse(value) > widget.remainMoney!) {
                    return '유효한 금액을 입력해주세요';
                  }
                  return null;
                },
              ),
            ],
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  child: Text('취소'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: Text('확인'),
                  onPressed: () {
                    if (_validateAmount()) {
                      // 쿠폰 사용 로직 추가...
                      Navigator.of(context).pop();
                    }
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  bool _validateAmount() {
    if (_amountController.text.isEmpty) {
      return false;
    }
    final amount = int.tryParse(_amountController.text);
    if (amount == null || amount > widget.remainMoney!) {
      return false;
    }
    return true;
  }
}
