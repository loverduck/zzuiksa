import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GifticonDetailScreen extends StatefulWidget {
  final Map<String, dynamic> data;
  const GifticonDetailScreen({Key? key, required this.data}) : super(key: key);

  @override
  _GifticonDetailScreenState createState() => _GifticonDetailScreenState();
}

class _GifticonDetailScreenState extends State<GifticonDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Gifticon Detail')),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: <Widget>[
          Text('Name: ${widget.data['name'] ?? 'N/A'}'),
          Text('Brand: ${widget.data['brand'] ?? 'N/A'}'),
          Text('Barcode: ${widget.data['barcode'] ?? 'N/A'}'),
          Text('Expiry Date: ${widget.data['expiryDate'] ?? 'N/A'}'),
          if (widget.data['amount'] != null)
            Text('Amount: ${widget.data['amount']}'),
          if (widget.data['memo'] != null)
            Text('Memo: ${widget.data['memo']}'),
        ],
      ),
    );
  }
}
