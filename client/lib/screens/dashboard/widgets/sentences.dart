import 'package:flutter/material.dart';
import 'package:client/constants.dart';

class Sentences extends StatefulWidget {
  const Sentences({super.key});
  @override
  State<Sentences> createState() => _SentencesState();
}

class _SentencesState extends State<Sentences> {
  String sentence = '주인님! 좋은 하루예요!';

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Center(
      child: Container(
        width: 140,
        height: 100,
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
            color: Constants.main100,
            border: Border.all(color: Constants.main600, width: 2.5),
            borderRadius: BorderRadius.circular(40)),
        child: Center(
          child: Text(sentence, style: textTheme.displaySmall),
        ),
      ),
    );
  }
}
