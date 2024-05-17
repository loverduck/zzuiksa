import 'package:client/screens/gifticon/service/merged_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:io';
import 'package:path/path.dart' as p;
import '../../../constants.dart';
import 'package:client/screens/gifticon/model/gifticon_model.dart';
import 'package:client/screens/gifticon/service/gifticon_api.dart';
import 'package:client/screens/gifticon/util/ocr_parser/recognize_template.dart';
import '../../utils/file_utils.dart';
import '../../utils/image_utils.dart';
import 'gifticon_detail_screen.dart';

class GifticonAddScreen extends StatefulWidget {
  final List<MergedField> ocrFields;
  final String? selectedImagePath;
  final Gifticon? gifticon;

  const GifticonAddScreen({super.key, required this.ocrFields, this.selectedImagePath, this.gifticon});

  @override
  State<GifticonAddScreen> createState() => _GifticonAddScreenState();
}

class _GifticonAddScreenState extends State<GifticonAddScreen> {
  late Gifticon _initialGifticon;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    String ocrText = widget.ocrFields.map((field) => field.text).join('\n');
    _initialGifticon = RecognizeTemplate.recognizeAndParse(ocrText);
    _initialGifticon.isUsed = "UNUSED";
  }

  void _handleSubmit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      _navigateToRegistrationCompleteScreen(_initialGifticon);
    }
  }

  // void _navigateToDetailScreen(Gifticon gifticon) async {
  //   try {
  //     if (widget.selectedImagePath != null) {
  //       final String localPath = '${await FileUtils.getFilePath()}/${p.basename(widget.selectedImagePath!)}';
  //       print("_navigateToDetailScreen");
  //       print(localPath);
  //
  //       // 로컬 이미지 파일 복사
  //       await FileUtils.copyLocalFile(widget.selectedImagePath!, localPath);
  //
  //       gifticon.url = localPath;
  //     }
  //     print("요청 전: gifticon= ");
  //     print(gifticon);
  //     Map<String, dynamic> res = await postGifticon(gifticon);
  //     print("요청 후: res[status]= ");
  //     print(res["status"]);
  //     print(res["errorCode"]);
  //     print(res["message"]);
  //     if (res["status"] == "success") {
  //       Map<String, dynamic> data = res["data"] as Map<String, dynamic>;
  //       int? gifticonId = data["gifticonId"] as int?;
  //       if (gifticonId != null) {
  //         print("gifticonId null이 아니다");
  //         Navigator.pushNamed(context, '/gifticon/detail', arguments: {"gifticonId": gifticonId});
  //       } else {
  //         print("gifticonId is null");
  //       }
  //     } else {
  //       throw Exception('Failed to get gifticon ID.');
  //     }
  //   } catch (e) {
  //     print(_navigateToDetailScreen);
  //     print(context);
  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("기프티콘 등록에 실패했습니다. 다시 시도해 주세요. 오류: $e"), backgroundColor: Colors.red));
  //   }
  // }

  void _navigateToRegistrationCompleteScreen(Gifticon gifticon) async {
    try {
      if (widget.selectedImagePath != null) {
        final String localPath = '${await FileUtils.getFilePath()}/${p.basename(widget.selectedImagePath!)}';
        await FileUtils.copyLocalFile(widget.selectedImagePath!, localPath);
        gifticon.url = localPath;
      }
      print(gifticon);
      Map<String, dynamic> res = await postGifticon(gifticon);
      if (res["status"] == "success") {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => GifticonRegistrationCompleteScreen()));
      } else {
        throw Exception('Failed to register gifticon.');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("기프티콘 등록에 실패했습니다. 다시 시도해 주세요. 오류: $e"), backgroundColor: Colors.red));
    }
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
        actions: [
          TextButton(
            onPressed: _handleSubmit,
            child: Text('등록하기', style: TextStyle(fontSize: 24, color: Constants.textColor)),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            if (widget.selectedImagePath != null)
              SizedBox(width: 300, height: 300, child: Image.file(File(widget.selectedImagePath!))),
            const SizedBox(height: 30),
            ListTile(
              title: Text('금액권인가요?', style: Theme.of(context).textTheme.displayMedium),
              trailing: Switch(
                value: _initialGifticon.remainMoney != null,
                onChanged: (bool value) {
                  setState(() {
                    _initialGifticon.remainMoney = value ? 0 : null;
                  });
                },
                activeColor: Constants.main400,
              ),
            ),
            _buildTextFormField('기프티콘명', _initialGifticon.name, (val) => _initialGifticon.name = val),
            _buildTextFormField('브랜드명', _initialGifticon.store, (val) => _initialGifticon.store = val),
            _buildTextFormField('바코드', _initialGifticon.couponNum, (val) => _initialGifticon.couponNum = val, isBarcode: true),
            _buildTextFormField('유효기간', _initialGifticon.endDate, (val) => _initialGifticon.endDate = val),
            if (_initialGifticon.remainMoney != null)
              _buildTextFormField('금액', _initialGifticon.remainMoney.toString(), (val) => _initialGifticon.remainMoney = int.tryParse(val)),
            _buildTextFormField('메모', _initialGifticon.memo, (val) => _initialGifticon.memo = val),
          ],
        ),
      ),
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

class GifticonRegistrationCompleteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('assets/images/temp.png'), // 완료 이미지, 경로는 실제 경로로 변경해주세요.
            Text("기프티콘 등록이 완료되었습니다."),
            ElevatedButton(
              child: Text('확인'),
              onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil('/gifticon', (Route<dynamic> route) => false),
            ),
          ],
        ),
      ),
    );
  }
}