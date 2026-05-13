import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';

class LocalStorage {
  static Future<File> _getFile(String fileName) async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/$fileName');
  }

  static Future<void> saveData(String fileName, dynamic data) async {
    final file = await _getFile(fileName);
    await file.writeAsString(jsonEncode(data));
  }

  static Future<dynamic> readData(String fileName) async {
    try {
      final file = await _getFile(fileName);
      String content = await file.readAsString();
      return jsonDecode(content);
    } catch (e) {
      return null;
    }
  }
}
