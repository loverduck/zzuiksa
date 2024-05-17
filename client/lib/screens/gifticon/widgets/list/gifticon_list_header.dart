import 'package:client/screens/gifticon/gifticon_select_screen.dart';
import 'package:flutter/material.dart';

class GifticonListHeader extends StatefulWidget {
  const GifticonListHeader({super.key});
  @override
  State<GifticonListHeader> createState() => _GifticonListHeaderState();
}

class _GifticonListHeaderState extends State<GifticonListHeader> {
  String sentence = '기프티콘 관리';

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Center(
      child: Container(
        margin: EdgeInsets.only(top: 30),
        width: 360,
        height: 100,
        padding: EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(sentence, style: textTheme.displayLarge),
              SizedBox(width: 10),
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => GifticonSelectScreen())
                ),
              ),
            ],
          ),
      ),
    );
  }
}
