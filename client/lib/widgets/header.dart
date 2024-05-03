import 'package:flutter/material.dart';

import '../screens/profile/widgets/butler/my_butler.dart';

class Header extends StatelessWidget {
  final String title;

  const Header(
      {super.key,
        required this.title});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return AppBar(
        backgroundColor: Colors.transparent,
        title: Text(title, style: textTheme.displayLarge),
        centerTitle: true,
        toolbarHeight: 80.0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings),
            iconSize: 32.0,
            padding: EdgeInsets.all(24),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MyButler()));
            },
          ),
        ],
    );
  }
}
