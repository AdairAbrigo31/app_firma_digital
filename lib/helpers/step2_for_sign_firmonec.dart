import 'dart:convert';
import 'dart:typed_data';
import 'package:firmonec/config/app_config_firmonec.dart';
import 'package:http/http.dart' as http;

class Step2ForSignFirmonec {
  static Future<Map<int, Uint8List>> getDocuments(String token) async {
    final response = await http.get(
      Uri.parse('${AppConfigFirmonec.instance.getUrlForSign()}/$token'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      Map<int, Uint8List> documents = {};

      for (var doc in data['documentos']) {
        int id = doc['id'];
        String base64Documento = doc['documento'];
        Uint8List documentoBytes = base64Decode(base64Documento);
        documents[id] = documentoBytes;
      }

      return documents;
    } else {
      print("Fallo al hacer el getDocuments");
      throw Exception('Error al obtener documentos: ${response.statusCode}');
    }
  }
}

