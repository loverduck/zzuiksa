import 'package:flutter/material.dart';

import 'package:client/constants.dart';

class Sentences extends StatefulWidget {
  const Sentences({super.key});
  @override
  State<Sentences> createState() => _SentencesState();
}

class _SentencesState extends State<Sentences> {
  String sentence = '김싸피님! 좋은 오후예요쮝!';

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Center(
      child: Container(
        width: 300,
        height: 100,
        margin: EdgeInsets.all(20),
        padding: EdgeInsets.only(top:16,bottom:16,left:32,right:32),
        decoration: BoxDecoration(
            color: Constants.main100,
            border: Border.all(color: Constants.main600, width: 2.5),
            borderRadius: BorderRadius.circular(64)),
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
