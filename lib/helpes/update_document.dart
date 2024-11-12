import 'dart:convert';
import 'package:firmonec/config/config_api.dart';
import 'package:http/http.dart' as http;

Future<void> updateDocument(
    String token,
    Map<int, String> signedDocuments,
    String cedula,
    ) async {
  try {
    // Crear la lista de documentos en el formato esperado
    List<Map<String, dynamic>> listdocuments = [];

    signedDocuments.forEach((id, base64) {
      if (base64.isNotEmpty) {
        listdocuments.add({
          'id': id,
          'documento': base64,
        });
      }
    });

    // Crear el objeto JSON que se enviará
    Map<String, dynamic> jsonMap = {
      'cedula': cedula,
      'documentos': listdocuments,
    };

    String jsonDocumentos = jsonEncode(jsonMap);

    // Enviar la solicitud PUT al servidor
    final response = await http.put(
      Uri.parse('${AppConfig.instance.getUrlFirmonec()}/$token'),
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: {
        'json': jsonDocumentos,
        'base64': base64Encode(utf8.encode(jsonDocumentos)),
      },
    );

    if (response.statusCode == 200) {
      print('Documento recibido: ${response.body}');

      try {
        final documentoJson = json.decode(response.body);
        print('Documento como JSON: $documentoJson');
      } catch (e) {
        print('Error al decodificar el JSON: $e');
      }

    } else {
      print('Error al actualizar los documentos: ${response.statusCode}');
      print('Respuesta del servidor: ${response.body}');
    }
  } catch (e) {
    print('Error en actualizarDocumento: $e');
  }
}
