import 'dart:io';

import 'package:client/screens/gifticon/gifticon_update_form_screen.dart';
import 'package:client/screens/gifticon/service/gifticon_api.dart';
import 'package:client/screens/gifticon/model/gifticon_model.dart';
import 'package:client/screens/gifticon/widgets/detail/gifticon_detail_info.dart';
import 'package:client/utils/image_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:client/constants.dart';
import 'package:flutter/widgets.dart';

import '../../utils/file_utils.dart';
import '../schedule/widgets/snackbar_text.dart';

class GifticonDetailScreen extends StatefulWidget {
  const GifticonDetailScreen({super.key,});

  @override
  State<GifticonDetailScreen> createState() => _GifticonDetailScreenState();
}

class _GifticonDetailScreenState extends State<GifticonDetailScreen> {
  late int gifticonId;
  late Gifticon gifticon;
  //
  void _getGifticon(int gifticonId, BuildContext context) async {
    Map<String, dynamic> res = await getGifticonDetail(gifticonId);

    if (res['status'] == 'success') {
      setState(() {
        gifticon = Gifticon.fromJson(res['data']);
        gifticon.gifticonId = gifticonId;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: SnackBarText(
            message: "로딩에 실패했습니다. 잠시 후 다시 시도해주세요",
          ),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    gifticon = Gifticon();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (ModalRoute.of(context)?.settings.arguments != null) {
        final args = ModalRoute.of(context)?.settings.arguments as Map;
        gifticonId = args['gifticonId'];
        _getGifticon(gifticonId, context);
      }
    });
  }

  Future<Widget> _loadImage() async {
    try {
      File imageFile = await ImageUtils.loadImage(gifticon.url!);
      return Image.file(
        imageFile,
        height: 150,
        width: 150,
        fit: BoxFit.cover,
      );
    } catch (e) {
      print("이미지 로딩에 실패했습니다: $e");
      return SizedBox.shrink(); // 이미지 로딩 실패 시 빈 위젯 반환
    }
  }

  void _showDeleteDialog() {
    if (gifticon.gifticonId == null) return;

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
                  bool deleted = await deleteGifticon(gifticon.gifticonId!);
                  if (deleted) {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
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
    if (gifticon.gifticonId == null) {
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: Constants.main200,
        ),
        body: Center(
          child: Text('유효한 기프티콘 ID가 제공되지 않았습니다.'),
        ),
      );
    }

    // ID가 유효한 경우의 UI 렌더링
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Constants.main200,
        actions: [
          PopupMenuButton<String>(
            onSelected: (String value) {
              if (value == 'edit') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GifticonUpdateScreen(gifticon: gifticon),
                  ),
                );
              } else if (value == 'delete') {
                _showDeleteDialog();
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
          : SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.0),
          child: Column(
            children: [
              FutureBuilder<Widget>(
                future: _loadImage(),
                builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('이미지 로딩 실패: ${snapshot.error}');
                  } else {
                    return snapshot.data ?? SizedBox.shrink();
                  }
                },
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
