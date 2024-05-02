import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailContainer extends StatefulWidget {
  const DetailContainer({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  State<DetailContainer> createState() => _DetailContainerState();
}

class _DetailContainerState extends State<DetailContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(
          color: Colors.black,
          width: 2.0,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: widget.child,
      ),
    );
  }
}
