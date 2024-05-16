import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'dart:io';

class FileUtils {
  static Future<String> getFilePath() async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  static Future<void> saveImage(File imageFile) async {
    final path = await getFilePath();
    final fileName = p.basename(imageFile.path);
    final newFile = File('$path/$fileName');

    await imageFile.copy(newFile.path);
  }
}
