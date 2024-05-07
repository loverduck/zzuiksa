import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final String title;
  final List<IconButton>? buttonList;

  const Header({super.key, required this.title, this.buttonList});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return AppBar(
      backgroundColor: Colors.transparent,
      title: Column(
        children: [
          SizedBox(height: 16),
          Text(title, style: textTheme.displayLarge)
        ],
      ),
      centerTitle: true,
      toolbarHeight: 80.0,
      actions: buttonList,
    );
  }
}
