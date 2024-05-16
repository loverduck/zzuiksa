import 'package:client/screens/gifticon/service/merged_field.dart';
import 'package:flutter/material.dart';
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

  const GifticonAddScreen({Key? key, required this.ocrFields, this.selectedImagePath}) : super(key: key);

  @override
  State<GifticonAddScreen> createState() => _GifticonAddScreenState();
}

class _GifticonAddScreenState extends State<GifticonAddScreen> {
  late Gifticon _initialGifticon;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    String ocrText = widget.ocrFields.map((field) => field.text).join('\n');
    _initialGifticon = RecognizeTemplate.recognizeAndParse(ocrText);
    _initialGifticon.isUsed = "미사용";
  }

  void _handleSubmit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      _navigateToDetailScreen(_initialGifticon);
    }
  }

  void _navigateToDetailScreen(Gifticon gifticon) async {
    try {
      if (widget.selectedImagePath != null) {
        final String localPath = '${await FileUtils.getFilePath()}/${p.basename(widget.selectedImagePath!)}';
        print("_navigateToDetailScreen");
        print(localPath);

        // 로컬 이미지 파일 복사
        await FileUtils.copyLocalFile(widget.selectedImagePath!, localPath);

        gifticon.url = localPath;
      }

      Gifticon createdGifticon = await postGifticon(gifticon);
      if (createdGifticon.id != null) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => GifticonDetailScreen(gifticonId: createdGifticon.id)));
      } else {
        throw Exception('Failed to get gifticon ID.');
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