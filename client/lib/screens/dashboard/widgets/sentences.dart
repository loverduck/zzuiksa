import 'package:flutter/material.dart';
import 'package:client/constants.dart';

class Sentences extends StatefulWidget {
  const Sentences({super.key});
  @override
  State<Sentences> createState() => _SentencesState();
}

class _SentencesState extends State<Sentences> {
  String sentence = '안녕하세요 김싸피님! 좋은 주말이에요쮝! '
      '기한이 임박한 기프티콘이 있어요쮝!';

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Center(
      child: Container(
        width: 190,
        height: 130,
        margin: EdgeInsets.all(12),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: Constants.main100,
            border: Border.all(color: Constants.main600, width: 2.5),
            borderRadius: BorderRadius.circular(40)),
        child: Center(
          child: Text(sentence,
              style: TextStyle(
                color: Constants.textColor,
                fontSize: 22,
                height: 1,
              )),
        ),
      ),
    );
  }
}
