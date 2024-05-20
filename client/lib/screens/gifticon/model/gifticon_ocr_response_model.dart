import '../service/merged_field.dart';

class GifticonOcrResponseModel {
  final List<MergedField> mergedFields;

  GifticonOcrResponseModel({required this.mergedFields});

  factory GifticonOcrResponseModel.fromJson(Map<String, dynamic> json) {
    var images = List<GifticonImageData>.from(json['images'].map((image) => GifticonImageData.fromJson(image)));
    var fields = images.isNotEmpty ? images[0].fields : <FieldData>[];
    var mergedFields = mergeFieldsByLine(fields);
    return GifticonOcrResponseModel(mergedFields: mergedFields);
  }
}

class GifticonImageData {
  final List<FieldData> fields;

  GifticonImageData({required this.fields});

  factory GifticonImageData.fromJson(Map<String, dynamic> json) {
    return GifticonImageData(
      fields: (json['fields'] as List<dynamic>?)
          ?.map((field) => FieldData.fromJson(field))
          .toList() ??
          <FieldData>[],
    );
  }
}

class FieldData {
  final List<Vertex> boundingPoly;
  final String inferText;

  FieldData({required this.boundingPoly, required this.inferText});

  factory FieldData.fromJson(Map<String, dynamic> json) {
    return FieldData(
      boundingPoly: List<Vertex>.from(json['boundingPoly']['vertices'].map((vertex) => Vertex.fromJson(vertex))),
      inferText: json['inferText'],
    );
  }
}

class Vertex {
  final int x;
  final int y;

  Vertex({required this.x, required this.y});

  factory Vertex.fromJson(Map<String, dynamic> json) {
    return Vertex(
      x: (json['x'] as num).toInt(),
      y: (json['y'] as num).toInt(),
    );
  }
}
