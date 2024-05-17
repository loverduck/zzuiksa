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
            // if (widget.nowGifticon.remainMoney != null) ...[
            //   Text(
            //     '남은 금액: ${widget.nowGifticon.remainMoney} 원',
            //     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            //   ),
            //   SizedBox(height: 10),
            //   TextFormField(
            //     controller: _amountController,
            //     decoration: InputDecoration(
            //       labelText: '사용한 금액',
            //       border: OutlineInputBorder(),
            //     ),
            //     keyboardType: TextInputType.number,
            //     validator: (value) {
            //       if (value == null || int.tryParse(value) == null || int.parse(value) > widget.remainMoney!) {
            //         return '유효한 금액을 입력해주세요';
            //       }
            //       return null;
            //     },
            //   ),
            // ],
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
                  onPressed: () {
                    if (_validateAmount()) {
                      _patchGifticon(widget.gifticon);
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
    final amount = int.tryParse(_amountController.text);
    return amount != null && amount <= widget.gifticon.remainMoney!;
  }

  Future<void> _patchGifticon(Gifticon nowGifticon) async {
    widget.gifticon.remainMoney = remainingMoney;
    widget.gifticon.isUsed = remainingMoney! > 0 ? 'INUSE' : 'USED';

    var res = await patchGifticon(widget.gifticon.gifticonId!, widget.gifticon);
    if (res != null && res['status'] == 'success') {
      Navigator.of(context).pop();
      print('Gifticon updated successfully.');
    } else {
      print('Failed to update gifticon.');
    }
  }
}
