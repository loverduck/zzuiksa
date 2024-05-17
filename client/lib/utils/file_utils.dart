import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'dart:io';

class FileUtils {
  static Future<String> getFilePath() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      print("getFilePath: ${directory.path}");
      return directory.path;
    } catch (e) {
      print("Error getting file path: $e");
      throw e;
    }
  }

  static Future<void> copyLocalFile(String sourcePath, String destinationPath) async {
    try {
      File sourceFile = File(sourcePath);
      await sourceFile.copy(destinationPath);
      print("File copied to $destinationPath");
    } catch (e) {
      print("Failed to copy file: $e");
      throw e;
    }
  }
}
