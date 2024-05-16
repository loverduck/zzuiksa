// import 'package:flutter/material.dart';
// import 'dart:io';
// import '../../../constants.dart';
// import 'package:client/screens/gifticon/model/gifticon_model.dart';
//
// class GifticonUpdateForm extends StatefulWidget {
//   final Gifticon initialGifticon;
//   final Function(Gifticon) onSubmit;
//
//   const GifticonUpdateForm({
//     Key? key,
//     required this.initialGifticon,
//     required this.onSubmit,
//   }) : super(key: key);
//
//   @override
//   State<GifticonUpdateForm> createState() => _GifticonUpdateFormState();
// }
//
// class _GifticonUpdateFormState extends State<GifticonUpdateForm> {
//   final _formKey = GlobalKey<FormState>();
//   late Gifticon _gifticon;
//
//   @override
//   void initState() {
//     super.initState();
//     _gifticon = widget.initialGifticon;
//   }
//
//   // @override
//   Widget build(BuildContext context) {
//     return Form(
//       key: _formKey,
//       child: ListView(
//         padding: const EdgeInsets.all(20),
//         children: <Widget>[
//           // Add your form fields here
//         ],
//       ),
//     );
//   }
// }
