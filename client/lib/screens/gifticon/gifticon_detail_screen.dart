import 'package:client/screens/gifticon/service/gifticon_api.dart';
import 'package:client/screens/gifticon/model/gifticon_model.dart';
import 'package:client/screens/gifticon/widgets/gifticon_detail_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:client/constants.dart';
import 'package:flutter/widgets.dart';

class GifticonDetailScreen extends StatefulWidget {
  const GifticonDetailScreen({
    super.key,
    required this.gifticonId,
  });

  final int gifticonId;

  @override
  State<GifticonDetailScreen> createState() => _GifticonDetailScreenState();
}

class _GifticonDetailScreenState extends State<GifticonDetailScreen> {
  Gifticon ? gifticon;

  // @override
  // void initState() {
  //   super.initState();
  //   getGifticonDetail(widget.gifticonId);
  // }

  @override
  void initState() {
    super.initState();
    // Mock data for testing
    gifticon = Gifticon(
        id: 1,
        name: '아이스아메리카노T',
        url: 'assets/images/tempGifticon.jpeg',
        store: '스타벅스',
        couponNum: '1234567890',
        endDate: '2024-05-31',
        isUsed: '미사용',
        remainMoney: 5000,
        memo: '커피 좋아!'
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Constants.main200,
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: (value) {
              switch (value) {
                case 'edit':
                //수정페이지로
                  break;
                case 'delete':
                //삭제하시겠습니까 뜨게
                  break;
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem<String>(
                  value: 'edit',
                  child: Text('정보 수정하기'),
                ),
                PopupMenuItem<String>(
                  value: 'delete',
                  child: Text('삭제하기'),
                ),
              ];
            },
          ),
        ],
      ),
      body: gifticon == null
          ? Center(child: CircularProgressIndicator())
          : Column(
        children: <Widget>[
          Image(
            image: AssetImage(gifticon!.url!),
            height: 150,
            width: 150,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 24),
          Container(
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Constants.main100,
              border: Border.all(color: Constants.main600, width: 2.5),
              borderRadius: BorderRadius.circular(25),
            ),
            child: GifticonDetailInfo(gifticon: gifticon!),
          ),
        ],
      ),
    );
  }
}
