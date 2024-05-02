import 'dart:math';

import 'package:client/constants.dart';
import 'package:flutter/material.dart';

class ChartPage extends StatelessWidget {
  List<double> points = [50, 90, 100, 20, 15, 5, 30];
  List<String> labels = ["일", "월", "화", "수", "목", "금", "토"]; //가로축 레이블

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Center(
        child: Column(
          children: <Widget>[
            Container(
              child: CustomPaint(
                  size: Size(300, 200),
                  foregroundPainter: BarChart(
                      data: points,
                      labels: labels,
                      color: Constants.main300)), // color - 막대 그래프의 색깔
            )
          ],
        ),
      ),
    );
  }
}

class BarChart extends CustomPainter {
  Color color;
  double textScaleFactorXAxis = 1.0; // x축 텍스트의 비율을 정함.
  double textScaleFactorYAxis = 1.2; // y축 텍스트의 비율을 정함.

  List<double> data = [];
  List<String> labels = [];
  double bottomPadding = 0.0;
  double leftPadding = 0.0;

  BarChart(
      {required this.data, required this.labels, this.color = Colors.blue});

  @override
  void paint(Canvas canvas, Size size) {
    setTextPadding(size); // 텍스트를 공간을 미리 정함.

    List<Offset> coordinates = getCoordinates(size);

    drawBar(canvas, size, coordinates);
    drawXLabels(canvas, size, coordinates);
    drawYLabels(canvas, size, coordinates);
  }

  void setTextPadding(Size size) {
    bottomPadding = size.height / 10; // 세로 크기의 1/10만큼만 텍스트 패딩을 줌
    leftPadding = size.width / 10; // 가로 길이의 1/10만큼 텍스트 패딩을 줌
  }

  void drawBar(Canvas canvas, Size size, List<Offset> coordinates) {
    Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill
      ..strokeCap = StrokeCap.round;

    double barWidthMargin = (size.width * 0.09); // 막대 그래프가 겹치지 않게 간격을 줌.

    for (var index = 0; index < coordinates.length; index++) {
      Offset offset = coordinates[index];
      double left = offset.dx;
      double right = offset.dx + barWidthMargin; // 간격만큼 가로로 이동
      double top = offset.dy;
      double bottom =
          size.height - bottomPadding; // 텍스트 크기만큼 패딩을 빼줘서, 텍스트와 겹치지 않게 함.

      // Rect rect = Rect.fromLTRB(right, top, left, bottom);
      // canvas.drawRect(rect, paint);

      Path path = Path();
      path.addRRect(RRect.fromRectAndRadius(
          Rect.fromLTRB(right, top, left, bottom), Radius.circular(15)));
      canvas.drawPath(path, paint);
    }
  }

  void drawXLabels(Canvas canvas, Size size, List<Offset> coordinates) {
    for (int index = 0; index < labels.length; index++) {
      TextSpan span = TextSpan(
          style: TextStyle(
              color: Constants.textColor,
              fontFamily: 'OwnglyphChongchong',
              fontSize: 24),
          text: labels[index]);

      TextPainter tp =
          TextPainter(text: span, textDirection: TextDirection.ltr);
      tp.layout();

      Offset offset = coordinates[index];
      double dx = offset.dx + 4;
      double dy = size.height - tp.height + 8;

      tp.paint(canvas, Offset(dx, dy));
    }
  }

  void drawYLabels(Canvas canvas, Size size, List<Offset> coordinates) {
    drawYText(canvas, '50%', 12, 90);
    drawYText(canvas, '100%', 12, 2);
  }

  // 화면 크기에 비례해 폰트 크기를 계산.
  // double calculateFontSize(String value, Size size, {required bool xAxis}) {
  //   int numberOfCharacters = value.length; // 글자수에 따라 폰트 크기를 계산하기 위함.
  //   double fontSize = (size.width / numberOfCharacters) /
  //       data.length; // width가 600일 때 100글자를 적어야 한다면, fontSize는 글자 하나당 6이어야겠죠.
  //
  //   if (xAxis) {
  //     fontSize *= textScaleFactorXAxis;
  //   } else {
  //     fontSize *= textScaleFactorYAxis;
  //   }
  //   return fontSize;
  // }

  // x축과 y축을 구분하는 선을 긋습니다.
  // void drawLines(Canvas canvas, Size size, List<Offset> coordinates) {
  //   Paint paint = Paint()
  //     ..color = Colors.blueGrey[100]!
  //     ..strokeCap = StrokeCap.round
  //     ..style = PaintingStyle.stroke
  //     ..strokeWidth = 1.8;
  //
  //   double bottom = size.height - bottomPadding;
  //   double left = coordinates[0].dx;
  //
  //   Path path = Path();
  //   path.moveTo(left, 0);
  //   path.lineTo(left, bottom);
  //   path.lineTo(size.width, bottom);
  //
  //   canvas.drawPath(path, paint);
  // }

  void drawYText(Canvas canvas, String text, double fontSize, double y) {
    TextSpan span = TextSpan(
      style: TextStyle(
          fontSize: fontSize,
          color: Colors.black,
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w600),
      text: text,
    );

    TextPainter tp = TextPainter(text: span, textDirection: TextDirection.ltr);

    tp.layout();

    Offset offset = Offset(0.0, y);
    tp.paint(canvas, offset);
  }

  List<Offset> getCoordinates(Size size) {
    List<Offset> coordinates = [];

    double maxData = data.reduce(max);

    double width = size.width - leftPadding;
    double minBarWidth = width / data.length;

    for (var index = 0; index < data.length; index++) {
      double left = minBarWidth * (index) + leftPadding; // 그래프의 가로 위치를 정합니다.
      double normalized =
          data[index] / maxData; // 그래프의 높이가 [0~1] 사이가 되도록 정규화 합니다.
      double height =
          size.height - bottomPadding; // x축에 표시되는 글자들과 겹치지 않게 높이에서 패딩을 제외합니다.
      double top = height - normalized * height; // 정규화된 값을 통해 높이를 구해줍니다.

      Offset offset = Offset(left, top);
      coordinates.add(offset);
    }

    return coordinates;
  }

  @override
  bool shouldRepaint(BarChart old) {
    return old.data != data;
  }
}
