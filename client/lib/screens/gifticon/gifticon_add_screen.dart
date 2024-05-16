// import 'package:client/screens/gifticon/service/gifticon_api.dart';
// import 'package:client/screens/gifticon/service/merged_field.dart';
// import 'package:client/screens/gifticon/util/ocr_parser/recognize_template.dart';
// import 'package:client/screens/gifticon/util/ocr_parser/parsers/ocr_default_parser.dart';
// import 'package:client/screens/gifticon/widgets/gifticon_add_form.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import '../../constants.dart';
//
// import '../../utils/file_utils.dart';
// import '../../utils/image_utils.dart';
// import 'gifticon_detail_screen.dart';
// import 'model/gifticon_model.dart';
// import 'widgets/gifticon_form.dart';
//
// class GifticonAddScreen extends StatefulWidget {
//   final List<MergedField> ocrFields;
//   final String? selectedImagePath;
//
//   // const GifticonAddScreen({super.key, required this.ocrFields, this.selectedImagePath});
//   // const GifticonAddScreen({Key? key, required this.ocrFields, this.selectedImagePath}) : super(key: key);
//   const GifticonAddScreen({Key? key, required this.ocrFields, this.selectedImagePath}) : super(key: key);
//
//   @override
//   State<GifticonAddScreen> createState() => _GifticonAddScreenState();
// }
//
// class _GifticonAddScreenState extends State<GifticonAddScreen> {
//   late Gifticon _initialGifticon;
//   final GlobalKey<_GifticonAddFormState> _formKey = GlobalKey<_GifticonAddFormState>();
//
//
//   @override
//   void initState() {
//     super.initState();
//     String ocrText = widget.ocrFields.map((field) => field.text).join('\n');
//     _initialGifticon = RecognizeTemplate.recognizeAndParse(ocrText);
//   }
//
//   void _handleSubmit() {
//     if (_formKey.currentState!.validate()) {
//       Gifticon gifticon = _formKey.currentState!.getFormGifticon();
//       _navigateToDetailScreen(gifticon);
//     }
//   }
//
//   void _navigateToDetailScreen(Gifticon gifticon) async {
//     try {
//       Gifticon createdGifticon = await postGifticon(gifticon);
//       if (createdGifticon.id != null) {
//         if (widget.selectedImagePath != null) {
//           final localPath = '${await FileUtils.getFilePath()}/${Uri.parse(widget.selectedImagePath!).pathSegments.last}';
//           await ImageUtils.saveImageToLocal(widget.selectedImagePath!, localPath);
//         }
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => GifticonDetailScreen(gifticonId: createdGifticon.id),
//           ),
//         );
//       } else {
//         throw Exception('Failed to get gifticon ID.');
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text("기프티콘 등록에 실패했습니다. 다시 시도해 주세요. 오류: $e"),
//             backgroundColor: Colors.red,
//           )
//       );
//     }
//   }
//
//   // @override
//   // Widget build(BuildContext context) {
//   //   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   //
//   //   return Scaffold(
//   //     appBar: AppBar(
//   //       leading: IconButton(
//   //         icon: Icon(Icons.arrow_back),
//   //         onPressed: () {
//   //           Navigator.of(context).pop();
//   //         },
//   //       ),
//   //       backgroundColor: Constants.main200,
//   //       actions: [
//   //         TextButton(
//   //           onPressed: () {
//   //             if (_formKey.currentState!.validate()) {
//   //               _formKey.currentState!.save();
//   //               // _gifticon이 null이 아닐 때만 네비게이션 실행
//   //               if (_gifticon != null) {
//   //                 _navigateToDetailScreen(_gifticon);
//   //               } else {
//   //                 ScaffoldMessenger.of(context).showSnackBar(
//   //                     SnackBar(
//   //                       content: Text("폼을 완성해주세요."),
//   //                       backgroundColor: Colors.red,
//   //                     )
//   //                 );
//   //               }
//   //             }
//   //           },
//   //           child: Text(
//   //             '등록하기',
//   //             style: TextStyle(
//   //               fontSize: 24,
//   //               color: Constants.textColor,
//   //             ),
//   //           ),
//   //         ),
//   //       ],
//   //     ),
//   //     body: GifticonForm(
//   //       key: _formKey,
//   //       initialGifticon: _initialGifticon,
//   //       selectedImagePath: widget.selectedImagePath,
//   //       isEdit: false,
//   //       onSubmit: (gifticon) {
//   //         if (gifticon != null) {
//   //           setState(() {
//   //             _gifticon = gifticon;
//   //           });
//   //         }
//   //       },
//   //     ),
//   //   );
//   // }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back),
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
//         ),
//         backgroundColor: Constants.main200,
//         actions: [
//           TextButton(
//             onPressed: _handleSubmit,
//             child: Text('등록하기', style: TextStyle(fontSize: 24, color: Constants.textColor)),
//           ),
//         ],
//       ),
//       body: GifticonAddForm(
//         key: _formKey,
//         initialGifticon: _initialGifticon,
//         selectedImagePath: widget.selectedImagePath,
//       ),
//     );
//   }
// }