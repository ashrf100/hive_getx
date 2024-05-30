import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class Result<T> {
  final T? data;
  final String? error;

  Result({this.data, this.error});

  bool get isSuccess => error == null;
}

abstract class FileService {
  Future<Result> exportData(List<Map<String, dynamic>> data, String fileName);
  Future<Result<List<Map<String, dynamic>>>> importData(String fileName);
}

class FileServiceImpl implements FileService {
  @override
  Future<Result> exportData(
      List<Map<String, dynamic>> data, String fileName) async {
    try {
      var status = await Permission.storage.request();
      if (!status.isGranted) {
        return Result(error: 'Storage permission denied');
      }

      final result = await FilePicker.platform.getDirectoryPath();
      if (result != null) {
        final String directoryPath = result;
        final File file = File('$directoryPath/$fileName');
        final jsonString = jsonEncode(data);

        await file.writeAsString(jsonString);

        return Result(data: 'Data exported to ${file.path}');
      } else {
        return Result(error: 'Directory not selected');
      }
    } catch (e) {
      return Result(error: 'Failed to export data: $e');
    }
  }

  @override
  Future<Result<List<Map<String, dynamic>>>> importData(String fileName) async {
    try {
      final result = await FilePicker.platform.pickFiles(
        dialogTitle: 'Please select a file to import:',
        type: FileType.custom,
        allowedExtensions: ['json'],
      );

      if (result != null && result.files.single.path != null) {
        final file = File(result.files.single.path!);
        final jsonString = await file.readAsString();
        final List<dynamic> jsonData = jsonDecode(jsonString);

        return Result(data: List<Map<String, dynamic>>.from(jsonData));
      } else {
        return Result(error: 'File not selected');
      }
    } catch (e) {
      return Result(error: 'Failed to import data: $e');
    }
  }
}
