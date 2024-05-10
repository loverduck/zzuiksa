import 'package:flutter/material.dart';
import 'dart:io';
import '../../../constants.dart';
import 'package:client/screens/gifticon/model/gifticon_model.dart';

class GifticonForm extends StatefulWidget {
  final Gifticon? initialGifticon;
  final Function(Gifticon) onSubmit;
  final bool isEdit;
  final String? selectedImagePath;

  const GifticonForm({
    Key? key,
    required this.onSubmit,
    this.initialGifticon,
    this.isEdit = false,
    this.selectedImagePath,
  }) : super(key: key);

  @override
  State<GifticonForm> createState() => _GifticonFormState();
}

class _GifticonFormState extends State<GifticonForm> {
  bool _isAmountVoucher = false;
  final _formKey = GlobalKey<FormState>();
  late Gifticon _gifticon;

  @override
  void initState() {
    super.initState();
    _gifticon = widget.initialGifticon ?? Gifticon();
    _isAmountVoucher = _gifticon.remainMoney != null;
  }

  void _handleSubmit() {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    widget.onSubmit(_gifticon);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: <Widget>[
          if (widget.selectedImagePath != null)
            SizedBox(
              width: 300,
              height: 300,
              child: Image.file(File(widget.selectedImagePath!)),
            ),
          const SizedBox(height: 30),
          ListTile(
            title: Text('금액권인가요?', style: Theme.of(context).textTheme.displayMedium),
            trailing: Switch(
              value: _isAmountVoucher,
              onChanged: (bool value) {
                setState(() {
                  _isAmountVoucher = value;
                  _gifticon.remainMoney = value ? 0 : null;
                });
              },
              activeColor: Constants.main400,
            ),
          ),
          const SizedBox(height: 30),
          _buildTextFormField(
            label: '기프티콘명',
            value: _gifticon.name,
            onChanged: (value) => _gifticon.name = value,
          ),
          _buildTextFormField(
            label: '브랜드명',
            value: _gifticon.store,
            onChanged: (value) => _gifticon.store = value,
          ),
          _buildTextFormField(
            label: '바코드',
            value: _gifticon.couponNum,
            onChanged: (value) => _gifticon.couponNum = value,
            isBarcode: true,
          ),

          _buildTextFormField(
            label: '유효기간',
            value: _gifticon.endDate,
            onChanged: (value) => _gifticon.endDate = value,
          ),
          if (_isAmountVoucher)
            _buildTextFormField(
              label: '금액',
              value: _gifticon.remainMoney?.toString(),
              onChanged: (value) => _gifticon.remainMoney = int.tryParse(value),
              keyboardType: TextInputType.number,
            ),
          _buildTextFormField(
            label: '메모',
            value: _gifticon.memo,
            onChanged: (value) => _gifticon.memo = value,
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: _handleSubmit,
            child: Text(widget.isEdit ? '수정하기' : '저장하기'),
          ),
        ],
      ),
    );
  }

  Widget _buildTextFormField({
    required String label,
    String? value,
    required Function(String) onChanged,
    TextInputType keyboardType = TextInputType.text,
    bool isBarcode = false,
  }) {
    return TextFormField(
      initialValue: value,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
        filled: true,
        fillColor: Constants.main100,
        contentPadding: const EdgeInsets.symmetric(horizontal: 30),
      ),
      style: Theme.of(context).textTheme.bodyLarge,
      onChanged: onChanged,
      keyboardType: keyboardType,
      validator: (value) {
        if (isBarcode) {
          return value != null && value.isNotEmpty ? null : '바코드를 입력해주세요.';
        } else {
          return null;
        }
      },
    );
  }
}
