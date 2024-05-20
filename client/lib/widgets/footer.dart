import 'package:client/constants.dart';
import 'package:flutter/material.dart';

class Footer extends StatefulWidget {
  const Footer({Key? key, required this.setBottomIndex}) : super(key: key);
  final Function setBottomIndex;

  @override
  State<Footer> createState() => _Footer();
}

class _Footer extends State<Footer> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
        onTap: (int index) {
          print('index test : ${index}');
          setState(() {
            _selectedIndex = index;
            widget.setBottomIndex(index);
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_month), label: 'Calendar'),
          BottomNavigationBarItem(icon: Icon(Icons.card_giftcard), label: 'Gifticon'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      iconSize: 36.0,
      selectedItemColor: Constants.main600,
      unselectedItemColor: Constants.main100,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      type: BottomNavigationBarType.fixed,
      backgroundColor: Constants.main300,
    );
  }
}