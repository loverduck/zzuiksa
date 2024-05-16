// import 'package:flutter/material.dart';
// import 'dart:io';
// import '../../../constants.dart';
// import 'package:client/screens/gifticon/model/gifticon_model.dart';
//
// class GifticonAddForm extends StatefulWidget {
//   final Gifticon initialGifticon;
//   final String? selectedImagePath;
//
//   const GifticonAddForm({
//     Key? key,
//     required this.initialGifticon,
//     this.selectedImagePath,
//   }) : super(key: key);
//
//   @override
//   State<GifticonAddForm> createState() => _GifticonAddFormState();
// }
//
// class _GifticonAddFormState extends State<GifticonAddForm> {
//   final _formKey = GlobalKey<FormState>();
//   late Gifticon _gifticon;
//   bool _isAmountVoucher = false;
//
//   @override
//   void initState() {
//     super.initState();
//     _gifticon = widget.initialGifticon; // 초기 기프티콘 객체로 폼을 채웁니다.
//     _isAmountVoucher = _gifticon.remainMoney != null;
//   }
//
//   Gifticon? getFormGifticon() {
//     if (_formKey.currentState!.validate()) {
//       _formKey.currentState!.save();
//       return _gifticon;
//     }
//     return null; // 유효성 검사에 실패하면 null을 반환
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       key: _formKey,
//       child: ListView(
//         padding: const EdgeInsets.all(20),
//         children: buildFormFields() + [const SizedBox(height: 30)],
//       ),
//     );
//   }
//
//   List<Widget> buildFormFields() {
//     return [
//       if (widget.selectedImagePath != null)
//         SizedBox(
//           width: 300,
//           height: 300,
//           child: Image.file(File(widget.selectedImagePath!)),
//         ),
//       const SizedBox(height: 30),
//       ListTile(
//         title: Text('금액권인가요?', style: Theme.of(context).textTheme.displayMedium),
//         trailing: Switch(
//           value: _isAmountVoucher,
//           onChanged: (bool value) {
//             setState(() {
//               _isAmountVoucher = value;
//               _gifticon.remainMoney = value ? 0 : null;
//             });
//           },
//           activeColor: Constants.main400,
//         ),
//       ),
//       _buildTextFormField(
//         label: '기프티콘명',
//         value: _gifticon.name,
//         onChanged: (value) => _gifticon.name = value,
//       ),
//       _buildTextFormField(
//         label: '브랜드명',
//         value: _gifticon.store,
//         onChanged: (value) => _gifticon.store = value,
//       ),
//       _buildTextFormField(
//         label: '바코드',
//         value: _gifticon.couponNum,
//         onChanged: (value) => _gifticon.couponNum = value,
//         isBarcode: true,
//         textStyle: Theme.of(context).textTheme.bodyLarge,
//       ),
//       _buildTextFormField(
//         label: '유효기간',
//         value: _gifticon.endDate,
//         onChanged: (value) => _gifticon.endDate = value,
//         textStyle: Theme.of(context).textTheme.bodyLarge,
//       ),
//       if (_isAmountVoucher)
//         _buildTextFormField(
//           label: '금액',
//           value: _gifticon.remainMoney?.toString(),
//           onChanged: (value) => _gifticon.remainMoney = int.tryParse(value),
//           keyboardType: TextInputType.number,
//         ),
//       _buildTextFormField(
//         label: '메모',
//         value: _gifticon.memo,
//         onChanged: (value) => _gifticon.memo = value,
//       ),
//     ];
//   }
//
//   Widget _buildTextFormField({
//     required String label,
//     String? value,
//     required Function(String) onChanged,
//     TextInputType keyboardType = TextInputType.text,
//     bool isBarcode = false,
//     TextStyle? textStyle,
//   }) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 10),
//       child: TextFormField(
//         initialValue: value,
//         decoration: InputDecoration(
//           labelText: label,
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(30.0),
//             borderSide: BorderSide(color: Constants.textColor),
//           ),
//           filled: true,
//           fillColor: Constants.main100,
//           contentPadding: const EdgeInsets.symmetric(horizontal: 30),
//         ),
//         style: textStyle ?? Theme.of(context).textTheme.displayMedium,
//         onChanged: onChanged,
//         keyboardType: keyboardType,
//         validator: (value) {
//           if (isBarcode) {
//             return value != null && value.isNotEmpty ? null : '바코드를 입력해주세요.';
//           } else {
//             return null;
//           }
//         },
//       ),
//     );
//   }
// }
