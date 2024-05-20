import 'dart:convert';

class GifticonOcrRequestModel {
  final List<ImageData> images;
  final String lang;
  final String requestId;
  final String resultType;
  final int timestamp;
  final String version;

  GifticonOcrRequestModel({
    required this.images,
    this.lang = 'ko',
    required this.requestId,
    required this.resultType,
    required this.timestamp,
    this.version = 'V2',
  });

  Map<String, dynamic> toJson() {
    return {
      'images': images.map((x) => x.toJson()).toList(),
      'lang': lang,
      'requestId': requestId,
      'resultType': resultType,
      'timestamp': timestamp,
      'version': version,
    };
  }

  String toRawJson() => json.encode(toJson());
}

class ImageData {
  final String format;
  final String name;
  final String? data;
  final String? url;

  ImageData({
    required this.format,
    required this.name,
    this.data,
    this.url,
  });

  Map<String, dynamic> toJson() {
    return {
      'format': format,
      'name': name,
      'data': data,
      'url': url,
    };
  }

  String toRawJson() => json.encode(toJson());
}