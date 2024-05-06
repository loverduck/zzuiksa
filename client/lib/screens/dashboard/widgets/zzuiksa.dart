import 'package:flutter/material.dart';

class Zzuiksa extends StatefulWidget {
  const Zzuiksa({super.key});
  @override
  State<Zzuiksa> createState() => _TodayState();
}

class _TodayState extends State<Zzuiksa> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Center(
        child: Image(image: AssetImage('assets/images/temp.png'),
          width: 110,
          height: 130,
        )
    );
  }
}
