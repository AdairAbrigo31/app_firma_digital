import 'package:file_picker/file_picker.dart';
import 'dart:convert';
import 'dart:io';

Future<Map<String, String>?> pickFile() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles();

  if (result != null && result.files.single.path != null) {
    String filePath = result.files.single.path!;
    String fileName = result.files.single.name;
    String fileBase64 = result.files.single.bytes != null
        ? base64Encode(result.files.single.bytes!)
        : await File(filePath).readAsBytes().then(base64Encode);

    return {'fileName': fileName, 'fileBase64': fileBase64};
  }
  return null;
}
