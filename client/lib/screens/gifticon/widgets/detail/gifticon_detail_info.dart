import 'package:client/constants.dart';
import 'package:client/screens/gifticon/widgets/detail/use_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:client/screens/gifticon/model/gifticon_model.dart';
import 'package:client/screens/gifticon/widgets/detail/gifticon_barcode_modal.dart';
import 'package:client/styles.dart';
import 'package:intl/intl.dart';

class GifticonDetailInfo extends StatefulWidget {
  final Gifticon gifticon;

  const GifticonDetailInfo({
    Key? key,
    required this.gifticon,
  }) : super(key: key);
  @override
  _GifticonDetailInfoState createState() => _GifticonDetailInfoState();
}

class _GifticonDetailInfoState extends State<GifticonDetailInfo> {
  void _showBarcodeModal(BuildContext context, Gifticon gifticon) {
    showCupertinoDialog(
      context: context,
      builder: (context) => BarcodeModal(gifticon: gifticon),
    );
  }

  @override
  Widget build(BuildContext context) {
    final endDate = widget.gifticon.endDate;
    final DateTime? endDateParsed = endDate != null ? DateTime.tryParse(endDate) : null;
    final int daysLeft = endDateParsed != null ? endDateParsed.difference(DateTime.now()).inDays : 0;
    final String daysLeftText = daysLeft >= 0 ? "D - $daysLeft" : "사용 기한이 지난 기프티콘입니다.";

    TextStyle dDayStyle = TextStyle(
      fontSize: 25,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    );

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Constants.pink400,
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            margin: const EdgeInsets.only(top: 4, bottom: 16),
            child: Text(
              daysLeftText,
              style: dDayStyle,
            ),
          ),
          Text(
            widget.gifticon.store ?? '사용처를 설정해보세요!',
            style: myTheme.textTheme.displayMedium,
          ),
          Text(
            widget.gifticon.name ?? '기프티콘명을 설정해보세요!',
            style: myTheme.textTheme.displayLarge?.copyWith(fontSize: 38),
          ),
          Text(
            '${widget.gifticon.endDate ?? 'N/A'} 까지 써야 해요!',
            style: myTheme.textTheme.displayMedium,
          ),
          Text(
            '남은 금액 : ${widget.gifticon.remainMoney ?? 'N/A'} 원',
            style: myTheme.textTheme.displayMedium,
          ),
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              border: Border.all(color: Constants.main600),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              widget.gifticon.memo ?? '작성한 메모가 없습니다.',
              style: TextStyle(fontSize: 24, color: widget.gifticon.memo?.isEmpty ?? true ? Colors.grey : Colors.black),
            ),
          ),
          const SizedBox(height: 16),
          Center(
            child: UseButton(
              onPressed: () {
                if (widget.gifticon.remainMoney != null && widget.gifticon.remainMoney! > 0) {
                  _showBarcodeModal(context, widget.gifticon);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("사용이 불가능한 기프티콘입니다."),
                    backgroundColor: Colors.red,
                  ));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}