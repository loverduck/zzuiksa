import 'dart:math';

class SFieldData {
  final List<Vertex> boundingPoly;
  final String inferText;

  SFieldData({required this.boundingPoly, required this.inferText});
}

class Vertex {
  final double x, y;

  Vertex({required this.x, required this.y});
}

class SMergedField {
  final List<Vertex> boundingPoly;
  final String text;

  SMergedField({required this.boundingPoly, required this.text});
}

List<SMergedField> SmergeSyrupFields(List<SFieldData> fields) {
  const int xThreshold = 120; // X 좌표가 이 값 미만인 경우 병합에서 제외
  const int yTolerance = 10;  // Y 좌표 허용 오차
  double? gifticonY = fields.firstWhere(
          (field) => field.inferText.toLowerCase().contains("gifticon"),
      orElse: () => SFieldData(boundingPoly: [Vertex(x: 0, y: double.infinity)], inferText: "")
  ).boundingPoly.first.y;

  List<SMergedField> SmergedFields = [];
  fields.sort((a, b) => a.boundingPoly.first.y.compareTo(b.boundingPoly.first.y));

  List<SFieldData> currentLine = [];
  double? currentY;

  for (var field in fields) {
    double fieldY = field.boundingPoly.first.y;

    // 'gifticon'의 y 좌표 이상에서 x 좌표가 xThreshold 미만인 텍스트는 병합에서 제외
    if (fieldY >= gifticonY && field.boundingPoly.first.x < xThreshold) {
      continue;
    }

    if (currentY == null || (fieldY - currentY).abs() <= yTolerance) {
      currentLine.add(field);
      currentY = fieldY;
    } else {
      if (currentLine.isNotEmpty) {
        SmergedFields.add(_SmergeFields(currentLine));
      }
      currentLine = [field];
      currentY = fieldY;
    }
  }

  if (currentLine.isNotEmpty) {
    SmergedFields.add(_SmergeFields(currentLine));
  }

  return SmergedFields;
}

SMergedField _SmergeFields(List<SFieldData> fields) {
  fields.sort((a, b) => a.boundingPoly.first.x.compareTo(b.boundingPoly.first.x));
  String mergedText = fields.map((field) => field.inferText).join(' ');
  List<Vertex> mergedBoundingPoly = _SmergeBoundingPoly(fields);

  return SMergedField(boundingPoly: mergedBoundingPoly, text: mergedText);
}

List<Vertex> _SmergeBoundingPoly(List<SFieldData> fields) {
  double minX = fields.map((field) => field.boundingPoly.first.x).reduce(min);
  double minY = fields.map((field) => field.boundingPoly.first.y).reduce(min);
  double maxX = fields.map((field) => field.boundingPoly.last.x).reduce(max);
  double maxY = fields.map((field) => field.boundingPoly.last.y).reduce(max);

  return [Vertex(x: minX, y: minY), Vertex(x: maxX, y: minY), Vertex(x: maxX, y: maxY), Vertex(x: minX, y: maxY)];
}
