import 'package:client/screens/gifticon/service/gifticon_api.dart';
import 'package:client/screens/gifticon/model/gifticon_model.dart';
import 'package:client/screens/gifticon/widgets/detail/gifticon_detail_info.dart';
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
  Gifticon? gifticon;

  @override
  void initState() {
    super.initState();
    fetchGifticonDetail();
  }

  Future<void> fetchGifticonDetail() async {
    try {
      Gifticon fetchedGifticon = await getGifticonDetail(widget.gifticonId);
      setState(() {
        gifticon = fetchedGifticon;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load gifticon: $e')),
      );
    }
  }

  void _showDeleteDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('삭제 확인'),
          content: Text('이 기프티콘을 삭제하시겠습니까?'),
          actions: <Widget>[
            TextButton(
              child: Text('취소'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('삭제하기'),
              onPressed: () async {
                try {
                  bool deleted = await deleteGifticon(widget.gifticonId);
                  if (deleted) {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();  // 삭제 후 이전 화면으로 이동
                  }
                } catch (e) {
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('삭제 실패: $e')),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Constants.main200,
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: (value) {
              switch (value) {
                case 'edit':
                  Navigator.pushNamed(context, '/gifticon_update_screen', arguments: gifticon);
                  break;
                case 'delete':
                  _showDeleteDialog();
                  break;
              }
            },
            itemBuilder: (BuildContext context) => [
              PopupMenuItem<String>(
                value: 'edit',
                child: Text('정보 수정하기'),
              ),
              PopupMenuItem<String>(
                value: 'delete',
                child: Text('삭제하기'),
              ),
            ],
          ),
        ],
      ),
      body: gifticon == null
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(  // 스크롤 가능하게 변경
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.0),  // 좌우 패딩 적용
          child: Column(
            children: [
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
        ),
      ),
    );
  }
}
