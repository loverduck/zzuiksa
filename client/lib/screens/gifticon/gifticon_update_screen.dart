import 'package:client/screens/gifticon/service/gifticon_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../constants.dart';
import 'model/gifticon_model.dart';
import 'gifticon_detail_screen.dart';
import 'widgets/gifticon_form.dart';

class GifticonUpdateScreen extends StatefulWidget {
  final Gifticon gifticon;

  static const androidIcon = Icon(Icons.card_giftcard);
  static const iosIcon = Icon(CupertinoIcons.news);

  const GifticonUpdateScreen({
    super.key,
    required this.gifticon
  });

  @override
  State<GifticonUpdateScreen> createState() => _GifticonUpdateScreenState();
}

class _GifticonUpdateScreenState extends State<GifticonUpdateScreen> {
  late Gifticon _gifticon;

  @override
  void initState() {
    super.initState();
    _gifticon = widget.gifticon;
  }

  Future<void> updateGifticon() async {
    if (_gifticon.id == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("유효한 기프티콘 ID가 없습니다."),
        backgroundColor: Colors.red,
      ));
      return;
    }

    try {
      Gifticon updatedGifticon = await patchGifticon(_gifticon.id!, _gifticon);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("기프티콘 정보가 성공적으로 수정되었습니다."),
      ));
      Navigator.of(context).pop(updatedGifticon);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("기프티콘 정보 수정에 실패했습니다. 오류: $e"),
        backgroundColor: Colors.red,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Constants.main200,
        actions: [
          TextButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                updateGifticon();
              }
            },
            child: Text(
              '수정하기',
              style: TextStyle(
                fontSize: 24,
                color: Constants.textColor,
              ),
            ),
          ),
        ],
      ),
      // body: GifticonForm(
      //   initialGifticon: gifticon,
      //   onSubmit: (updatedGifticon) {
      //     setState(() {
      //       gifticon = updatedGifticon;
      //     });
      //     updateGifticon();
      //   },
      // ),
      body: GifticonForm(
        key: _formKey,
        initialGifticon: _gifticon,
        onSubmit: (updatedGifticon) {
          setState(() {
            _gifticon = updatedGifticon;
          });
          updateGifticon();
        },
        isEdit: true,
      ),
    );
  }
}
