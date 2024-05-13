import 'dart:math';

import '../model/gifticon_ocr_response_model.dart';

class MergedField {
  final List<Vertex> boundingPoly;
  final String text;

  MergedField({required this.boundingPoly, required this.text});
}

List<MergedField> mergeFieldsByLine(List<FieldData> fields) {
  const tolerance = 10; // Adjust this value as needed to account for small variations in y-coordinates

  List<MergedField> mergedFields = [];

  fields.sort((a, b) => a.boundingPoly.first.y.compareTo(b.boundingPoly.first.y));

  List<FieldData> currentLine = [];
  int? currentY;

  for (var field in fields) {
    int fieldY = field.boundingPoly.first.y;

    if (currentY == null || (fieldY - currentY).abs() <= tolerance) {
      currentLine.add(field);
      currentY = fieldY;
    } else {
      mergedFields.add(_mergeFields(currentLine));
      currentLine = [field];
      currentY = fieldY;
    }
  }

  if (currentLine.isNotEmpty) {
    mergedFields.add(_mergeFields(currentLine));
  }

  return mergedFields;
}

MergedField _mergeFields(List<FieldData> fields) {
  fields.sort((a, b) => a.boundingPoly.first.x.compareTo(b.boundingPoly.first.x));

  String mergedText = fields.map((field) => field.inferText).join(' ');

  List<Vertex> mergedBoundingPoly = _mergeBoundingPoly(fields);

  return MergedField(boundingPoly: mergedBoundingPoly, text: mergedText);
}

List<Vertex> _mergeBoundingPoly(List<FieldData> fields) {
  int minX = fields.map((field) => field.boundingPoly.first.x).reduce(min);
  int minY = fields.map((field) => field.boundingPoly.first.y).reduce(min);
  int maxX = fields.map((field) => field.boundingPoly.last.x).reduce(max);
  int maxY = fields.map((field) => field.boundingPoly.last.y).reduce(max);

  return [Vertex(x: minX, y: minY), Vertex(x: maxX, y: minY), Vertex(x: maxX, y: maxY), Vertex(x: minX, y: maxY)];
}

List<MergedField> mergeSyrupFields(List<FieldData> fields) {
  const xTolerance = 50;  // X 좌표 내에서 허용하는 최대 변동
  const yTolerance = 10;  // Y 좌표 내에서 허용하는 최대 변동

  List<MergedField> mergedFields = [];

  // Y 좌표에 따라 필드를 정렬
  fields.sort((a, b) => a.boundingPoly.first.y.compareTo(b.boundingPoly.first.y));

  List<FieldData> currentLine = [];
  int? currentY, currentX;

  for (var field in fields) {
    int fieldX = field.boundingPoly.first.x;
    int fieldY = field.boundingPoly.first.y;

    if (currentY == null || (fieldY - currentY).abs() <= yTolerance) {
      if (currentX == null || (fieldX - currentX).abs() <= xTolerance) {
        currentLine.add(field);
        currentX = fieldX;
      }
    } else {
      if (currentLine.isNotEmpty) {
        mergedFields.add(_mergeFields(currentLine));
      }
      currentLine = [field];
      currentX = fieldX;
    }
    currentY = fieldY;
  }

  if (currentLine.isNotEmpty) {
    mergedFields.add(_mergeFields(currentLine));
  }

  return mergedFields;
}
