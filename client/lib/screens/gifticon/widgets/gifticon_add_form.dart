import 'package:flutter/material.dart';

import '../../../constants.dart';

class GifticonAddForm extends StatefulWidget {
  final Function(Map<String, dynamic>) onSubmit;
  GifticonAddForm({Key? key, required this.onSubmit}) : super(key: key);

  @override
  _GifticonAddFormState createState() => _GifticonAddFormState();
}

class _GifticonAddFormState extends State<GifticonAddForm> {
  bool _isAmountVoucher = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _brandController = TextEditingController();
  final TextEditingController _barcodeController = TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _memoController = TextEditingController();

  void _handleSubmit() {
    if (!_formKey.currentState!.validate()) {
      return;  // 폼 검증 실패 시 리턴
    }
    Map<String, dynamic> formData = {
      'url': 'assets/images/tempGifticon.jpeg',
      'name': _nameController.text,
      'brand': _brandController.text,
      'barcode': _barcodeController.text,
      'expiryDate': _expiryDateController.text,
      'amount': _isAmountVoucher ? _amountController.text : null,
      'memo': _memoController.text.isNotEmpty ? _memoController.text : null,
    };
    widget.onSubmit(formData);  // 콜백 함수 실행
  }

  @override
  void dispose() {
    _nameController.dispose();
    _brandController.dispose();
    _barcodeController.dispose();
    _expiryDateController.dispose();
    _amountController.dispose();
    _memoController.dispose();
    super.dispose();
  }

  Widget _buildTextFormField({
    required TextEditingController controller,
    String? Function(String?)? validator,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
        filled: true,
        fillColor: Constants.main100,
        contentPadding: EdgeInsets.symmetric(horizontal: 30),
      ),
      style: Theme.of(context).textTheme.bodyLarge,
      validator: validator,
      keyboardType: keyboardType,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        padding: EdgeInsets.all(20),
        children: <Widget>[
          Container(
            width: 300,
            height: 300,
            child: Image(
              image: AssetImage('assets/images/tempGifticon.jpeg'),
            ),
          ),
          SizedBox(height: 30),
          ListTile(
            title: Text(
              '금액권인가요?',
              style: Theme.of(context).textTheme.displayMedium,
            ),
            trailing: Switch(
              value: _isAmountVoucher,
              onChanged: (bool value) {
                setState(() {
                  _isAmountVoucher = value;
                });
              },
              activeColor: Constants.main400, // 활성화 색상 지정
            ),
          ),
          SizedBox(height: 30),
          Text('기프티콘명', style: Theme.of(context).textTheme.displayMedium),
          _buildTextFormField(
            controller: _nameController,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return '기프티콘명을 입력해주세요.';
              }
              return null;
            },
          ),
          Text('브랜드명', style: Theme.of(context).textTheme.displayMedium),
          _buildTextFormField(
            controller: _brandController,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return '브랜드명을 입력해주세요.';
              }
              return null;
            },
          ),
          Text('바코드', style: Theme.of(context).textTheme.displayMedium),
          _buildTextFormField(
            controller: _barcodeController,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return '바코드 번호를 입력해주세요.';
              }
              return null;
            },
          ),
          Text('유효기간', style: Theme.of(context).textTheme.displayMedium),
          _buildTextFormField(
            controller: _expiryDateController,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return '유효기간을 입력해주세요.';
              }
              return null;
            },
          ),
          if (_isAmountVoucher)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('금액', style: Theme.of(context).textTheme.displayMedium),
                _buildTextFormField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
          Text('메모', style: Theme.of(context).textTheme.displayMedium),
          _buildTextFormField(
            controller: _memoController,
          ),
        ],
      ),
    );
  }
}
