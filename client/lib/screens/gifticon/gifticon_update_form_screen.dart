import 'package:client/screens/gifticon/service/gifticon_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../constants.dart';
import 'dart:io';
import '../../utils/image_utils.dart';
import 'model/gifticon_model.dart';

class GifticonUpdateScreen extends StatefulWidget {
  final Gifticon gifticon;

  const GifticonUpdateScreen({
    super.key,
    required this.gifticon
  });

  @override
  State<GifticonUpdateScreen> createState() => _GifticonUpdateScreenState();
}

class _GifticonUpdateScreenState extends State<GifticonUpdateScreen> {
  late Gifticon _gifticon;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _gifticon = widget.gifticon;
  }

  Future<void> updateGifticon() async {
    if (_gifticon.gifticonId == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("유효한 기프티콘 ID가 없습니다."),
        backgroundColor: Colors.red,
      ));
      return;
    }

    try {
      int updatedGifticonId = await patchGifticon(_gifticon.gifticonId!, _gifticon);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("기프티콘 정보가 성공적으로 수정되었습니다."),
      ));
      Navigator.of(context).pop(updatedGifticonId);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("기프티콘 정보 수정에 실패했습니다. 오류: $e"),
        backgroundColor: Colors.red,
      ));
    }
  }

  Future<Widget> _loadImage() async {
    if (_gifticon.url != null) {
      try {
        File imageFile = await ImageUtils.loadImage(_gifticon.url!);
        return Image.file(
          imageFile,
          height: 300,
          width: 300,
          fit: BoxFit.cover,
        );
      } catch (e) {
        print("Failed to load image: $e");
        return SizedBox.shrink(); // 이미지 로딩 실패 시 빈 위젯 반환
      }
    } else {
      return SizedBox.shrink(); // url이 없는 경우 빈 위젯 반환
    }
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
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            if (_gifticon.url != null)
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
            const SizedBox(height: 30),
            ListTile(
              title: Text('금액권인가요?', style: Theme.of(context).textTheme.displayMedium),
              trailing: Switch(
                value: _gifticon.remainMoney != null,
                onChanged: (bool value) {
                  setState(() {
                    _gifticon.remainMoney = value ? 0 : null;
                  });
                },
                activeColor: Constants.main400,
              ),
            ),
            _buildTextFormField('기프티콘명', _gifticon.name, (val) => _gifticon.name = val),
            _buildTextFormField('브랜드명', _gifticon.store, (val) => _gifticon.store = val),
            _buildTextFormField('바코드', _gifticon.couponNum, (val) => _gifticon.couponNum = val, isBarcode: true),
            _buildTextFormField('유효기간', _gifticon.endDate, (val) => _gifticon.endDate = val),
            if (_gifticon.remainMoney != null)
              _buildTextFormField('금액', _gifticon.remainMoney.toString(), (val) => _gifticon.remainMoney = int.tryParse(val)),
            _buildTextFormField('메모', _gifticon.memo, (val) => _gifticon.memo = val),
          ],
        ),
      )
    );
  }
  Widget _buildTextFormField(String label, String? value, Function(String) onChanged, {bool isBarcode = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        initialValue: value,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0), borderSide: BorderSide(color: Constants.textColor)),
          filled: true,
          fillColor: Constants.main100,
          contentPadding: const EdgeInsets.symmetric(horizontal: 30),
        ),
        style: Theme.of(context).textTheme.displayMedium,
        onChanged: onChanged,
        keyboardType: isBarcode ? TextInputType.number : TextInputType.text,
        validator: (value) {
          if (isBarcode && (value == null || value.isEmpty)) {
            return '바코드를 입력해주세요.';
          }
          return null;
        },
      ),
    );
  }
}
