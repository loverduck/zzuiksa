// // import 'dart:convert';
// // import 'dart:io';
// //
// // import 'package:client/screens/gifticon/service/merged_field.dart';
// // import 'package:flutter/cupertino.dart';
// // import 'package:flutter/material.dart';
// // import 'package:image_picker/image_picker.dart';
// // import 'package:flutter_dotenv/flutter_dotenv.dart';
// //
// // import '../../constants.dart';
// // import 'gifticon_add_screen.dart';
// // import 'model/gifticon_ocr_request_model.dart';
// // import 'model/gifticon_ocr_response_model.dart';
// // import 'service/gifticon_ocr_api.dart';
// //
// // class GifticonSelectScreen extends StatefulWidget {
// //   const GifticonSelectScreen({super.key});
// //
// //   @override
// //   State<GifticonSelectScreen> createState() => _GifticonSelectScreenState();
// // }
// //
// // class _GifticonSelectScreenState extends State<GifticonSelectScreen> {
// //   String? _selectedImagePath;
// //   List<MergedField> _ocrResults = [];
// //   final _ocrApi = GifticonOcrApi();
// //   bool _isLoading = false;
// //
// //   Future<void> _pickImage() async {
// //     final imagePicker = ImagePicker();
// //     final pickedImage = await imagePicker.pickImage(source: ImageSource.gallery);
// //
// //     if (pickedImage != null) {
// //       setState(() {
// //         _selectedImagePath = pickedImage.path;
// //       });
// //     }
// //   }
// //
// //   Future<void> _sendOcrRequest() async {
// //     if (_selectedImagePath == null) return;
// //
// //     setState(() {
// //       _isLoading = true;
// //     });
// //
// //     final pickedImage = File(_selectedImagePath!);
// //     final model = GifticonOcrRequestModel(
// //       images: [
// //         ImageData(
// //           format: pickedImage.path.split('.').last,
// //           name: "medium",
// //           url: null,
// //           data: base64Encode(await pickedImage.readAsBytes()),
// //         ),
// //       ],
// //       requestId: "unique_request_id",
// //       resultType: "string",
// //       timestamp: DateTime.now().millisecondsSinceEpoch,
// //     );
// //
// //     try {
// //       final result = await _ocrApi.requestOcr(model);
// //       final response = GifticonOcrResponseModel.fromJson(result);
// //       setState(() {
// //         _ocrResults = response.mergedFields;
// //         _isLoading = false;
// //       });
// //       Navigator.push(
// //         context,
// //         MaterialPageRoute(
// //           builder: (context) => GifticonAddScreen(ocrFields: _ocrResults, selectedImagePath: _selectedImagePath),
// //         ),
// //       );
// //     } catch (e) {
// //       print("OCR request failed: $e");
// //       setState(() {
// //         _isLoading = false;
// //       });
// //     }
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     final textTheme = Theme.of(context).textTheme;
// //
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Center(
// //           child: Text('이미지 선택', style: textTheme.displayLarge),
// //         ),
// //         leading: IconButton(
// //           icon: const Icon(Icons.arrow_back),
// //           onPressed: () {
// //             Navigator.of(context).pop();
// //           },
// //         ),
// //         backgroundColor: Constants.main200,
// //         actions: [
// //           TextButton(
// //             onPressed: _isLoading ? null : _sendOcrRequest,
// //             child: Text(
// //               '다음',
// //               style: TextStyle(
// //                 fontSize: 24,
// //                 color: Constants.textColor,
// //               ),
// //             ),
// //           ),
// //         ],
// //       ),
// //       body: Center(
// //         child: InkWell(
// //           onTap: _pickImage,
// //           child: _selectedImagePath == null
// //               ? Column(
// //             mainAxisAlignment: MainAxisAlignment.center,
// //             children: <Widget>[
// //               Icon(Icons.add_photo_alternate, size: 50, color: Colors.black),
// //               SizedBox(height: 20),
// //               Text('이미지를 선택하세요.', style: TextStyle(color: Colors.black, fontSize: 18)),
// //             ],
// //           )
// //               : Image.file(File(_selectedImagePath!)),
// //         ),
// //       ),
// //     );
// //   }
// // }
//
// import 'dart:convert';
// import 'dart:io';
//
// import 'package:client/screens/gifticon/service/merged_field.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:image_cropper/image_cropper.dart';
//
// import '../../constants.dart';
// import 'gifticon_add_screen.dart';
// import 'model/gifticon_ocr_request_model.dart';
// import 'model/gifticon_ocr_response_model.dart';
// import 'service/gifticon_ocr_api.dart';
//
// class GifticonSelectScreen extends StatefulWidget {
//   const GifticonSelectScreen({super.key});
//
//   @override
//   State<GifticonSelectScreen> createState() => _GifticonSelectScreenState();
// }
//
// class _GifticonSelectScreenState extends State<GifticonSelectScreen> {
//   String? _selectedImagePath;
//   String? _croppedImagePath;
//   List<MergedField> _ocrResults = [];
//   final _ocrApi = GifticonOcrApi();
//   bool _isLoading = false;
//
//   Future<void> _pickImage() async {
//     final imagePicker = ImagePicker();
//     final pickedImage = await imagePicker.pickImage(source: ImageSource.gallery);
//
//     if (pickedImage != null) {
//       _selectedImagePath = pickedImage.path;
//       final croppedImage = await ImageCropper().cropImage(
//           sourcePath: pickedImage.path,
//           aspectRatioPresets: [
//             CropAspectRatioPreset.square,
//             CropAspectRatioPreset.ratio3x2,
//             CropAspectRatioPreset.original,
//             CropAspectRatioPreset.ratio4x3,
//             CropAspectRatioPreset.ratio16x9
//           ],
//           uiSettings: [
//             AndroidUiSettings(
//               toolbarTitle: '사진 자르기',
//               toolbarColor: Constants.main200,
//               toolbarWidgetColor: Constants.main600,
//               initAspectRatio: CropAspectRatioPreset.original,
//               lockAspectRatio: false),
//             IOSUiSettings(
//               minimumAspectRatio: 1.0,
//             )
//           ]
//       );
//       setState(() {
//         _croppedImagePath = croppedImage?.path;
//       });
//     }
//   }
//
//   Future<void> _sendOcrRequest() async {
//     if (_croppedImagePath == null) return;
//     setState(() {
//       _isLoading = true;
//     });
//
//     final croppedImage = File(_croppedImagePath!);
//     final model = GifticonOcrRequestModel(
//       images: [
//         ImageData(
//           format: croppedImage.path.split('.').last,
//           name: "medium",
//           url: null,
//           data: base64Encode(await croppedImage.readAsBytes()),
//         ),
//       ],
//       requestId: "unique_request_id",
//       resultType: "string",
//       timestamp: DateTime.now().millisecondsSinceEpoch,
//     );
//
//     try {
//       final result = await _ocrApi.requestOcr(model);
//       final response = GifticonOcrResponseModel.fromJson(result);
//       setState(() {
//         _ocrResults = response.mergedFields;
//         _isLoading = false;
//       });
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => GifticonAddScreen(ocrFields: _ocrResults, selectedImagePath: _selectedImagePath),
//         ),
//       );
//     } catch (e) {
//       print("OCR request failed: $e");
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final textTheme = Theme.of(context).textTheme;
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Center(
//           child: Text('이미지 선택', style: textTheme.displayLarge),
//         ),
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
//         ),
//         backgroundColor: Constants.main200,
//         actions: [
//           TextButton(
//             onPressed: _isLoading ? null : _sendOcrRequest,
//             child: Text(
//               '다음',
//               style: TextStyle(
//                 fontSize: 24,
//                 color: Constants.textColor,
//               ),
//             ),
//           ),
//         ],
//       ),
//       body: Center(
//         child: InkWell(
//           onTap: _pickImage,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               Text(
//                 _croppedImagePath == null ? '이미지를 선택하세요' : '다시 선택하기',
//                 style: TextStyle(color: Colors.black, fontSize: 18),
//               ),
//               Icon(Icons.add_photo_alternate, size: 50, color: Colors.black),
//               SizedBox(height: 40),
//               if (_croppedImagePath != null)
//                 Image.file(File(_croppedImagePath!)),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:convert';
import 'dart:io';

import 'package:client/screens/gifticon/service/merged_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../constants.dart';
import 'gifticon_add_screen.dart';
import 'model/gifticon_ocr_request_model.dart';
import 'model/gifticon_ocr_response_model.dart';
import 'service/gifticon_ocr_api.dart';

class GifticonSelectScreen extends StatefulWidget {
  const GifticonSelectScreen({super.key});

  @override
  State<GifticonSelectScreen> createState() => _GifticonSelectScreenState();
}

class _GifticonSelectScreenState extends State<GifticonSelectScreen> {
  String? _selectedImagePath;
  List<MergedField> _ocrResults = [];
  final _ocrApi = GifticonOcrApi();
  bool _isLoading = false;

  Future<void> _pickImage() async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _selectedImagePath = pickedImage.path;
      });
    }
  }

  Future<void> _sendOcrRequest() async {
    if (_selectedImagePath == null) return;

    _showLoadingDialog();
    setState(() {
      _isLoading = true;
    });

    final pickedImage = File(_selectedImagePath!);
    final model = GifticonOcrRequestModel(
      images: [
        ImageData(
          format: pickedImage.path.split('.').last,
          name: "medium",
          url: null,
          data: base64Encode(await pickedImage.readAsBytes()),
        ),
      ],
      requestId: "unique_request_id",
      resultType: "string",
      timestamp: DateTime.now().millisecondsSinceEpoch,
    );

    try {
      final result = await _ocrApi.requestOcr(model);
      final response = GifticonOcrResponseModel.fromJson(result);
      setState(() {
        _ocrResults = response.mergedFields;
        _isLoading = false;
      });
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => GifticonAddScreen(ocrFields: _ocrResults, selectedImagePath: _selectedImagePath),
        ),
      );
    } catch (e) {
      print("OCR request failed: $e");
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showLoadingDialog() {
    showDialog(
      context: context,
      barrierDismissible: false, // Prevents dialog from being dismissed by tapping outside of it
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30), // Adjusted padding
            decoration: BoxDecoration(
              color: Colors.white, // Set a background color for contrast
              borderRadius: BorderRadius.circular(10), // Rounded corners for aesthetics
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min, // Restricts the column size to its children's size
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 70,
                  height: 90,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/temp.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 20), // Provides vertical spacing between image and text
                Text(
                  "이미지 정보를\n읽어오는 중입니다!",
                  textAlign: TextAlign.center, // Centers the text horizontally
                  style: TextStyle(
                    color: Constants.textColor, // Ensures text color is set for visibility
                    fontSize: 28, // Adjusted font size for balance
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('이미지 선택', style: textTheme.displayLarge),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Constants.main200,
        actions: [
          TextButton(
            onPressed: _isLoading ? null : _sendOcrRequest,
            child: Text(
              '다음',
              style: TextStyle(
                fontSize: 24,
                color: Constants.textColor,
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (_selectedImagePath == null)
              ElevatedButton.icon(
                onPressed: _pickImage,
                icon: const Icon(Icons.add_photo_alternate, size: 24, color: Colors.white),  // Adjust color and size as necessary
                label: Text('이미지를 선택하세요.', style: TextStyle(fontSize: 28, color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: Colors.orange, // This affects the text color of the icon as well
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    // border: Constants.main200,
                    side: BorderSide(color: Colors.orange),
                  ),
                ),
              ),
            if (_selectedImagePath != null) ...[
              Text('선택한 이미지', style: TextStyle(color: Colors.black, fontSize: 30)),
              SizedBox(height: 10),
              Image.file(File(_selectedImagePath!), width: 350, height: 350, fit: BoxFit.contain),
              SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: _pickImage,
                icon: const Icon(Icons.add_photo_alternate, size: 24, color: Colors.white),  // Adjust color and size as necessary
                label: Text('다시 선택하기', style: TextStyle(fontSize: 28, color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: Colors.orange, // This affects the text color of the icon as well
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    // border: Constants.main200,
                    side: BorderSide(color: Colors.orange),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
