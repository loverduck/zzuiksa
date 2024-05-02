import 'package:flutter/material.dart';

import 'package:client/constants.dart';

class GraphContainer extends StatelessWidget {
  const GraphContainer(
      {super.key, this.category, required this.bgColor, required this.percent});
  final String? category;
  final Color bgColor;
  final int percent;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
        width: 340,
        height: 50,
        margin: EdgeInsets.all(8),
        padding: EdgeInsets.all(4),
        decoration: BoxDecoration(
            border: Border.all(color: Constants.main600, width: 2),
            borderRadius: BorderRadius.circular(30),
            color: Constants.main100),
        child: Align(
            alignment: Alignment.centerLeft,
            child: Container(
                width: 3.4 * percent,
                height: 42,
                padding: EdgeInsets.only(right: 8),
                decoration: BoxDecoration(
                    border: Border.all(color: Constants.main600, width: 2),
                    borderRadius: BorderRadius.circular(30),
                    color: bgColor),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (category != null)
                      Text(
                        category!,
                        style: textTheme.displaySmall,
                      ),
                    Text(' ${percent}%', style: textTheme.bodySmall),
                  ],
                ))));
  }
}
