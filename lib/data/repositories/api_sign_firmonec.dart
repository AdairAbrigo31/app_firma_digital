import 'dart:convert';
import 'package:firmonec/config/app_config_firmonec.dart';
import 'package:http/http.dart' as http;
import 'package:firmonec/domain/repositories/api_sign.dart';
import 'dart:typed_data';
import '../../helpers/forGetToken.dart';

class ApiSignFirmonec implements ApiSign {

  @override
  Future<Map<int, Uint8List>> getDocumentValidated(String token) async {
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

  @override
  Future<dynamic> updateDocumentSigned(String token, Map<int, String> signedDocuments, String idUser) async {
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
        'cedula': idUser,
        'documentos': listdocuments,
      };

      String jsonDocumentos = jsonEncode(jsonMap);

      // Enviar la solicitud PUT al servidor
      final response = await http.put(
        Uri.parse('${AppConfigFirmonec.instance.getUrlForSign()}/$token'),
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
        return true;
      } else {
        print('Error al actualizar los documentos: ${response.statusCode}');
        print('Respuesta del servidor: ${response.body}');
        return false;
      }
    } catch (e) {
      // print('Error en actualizarDocumento: $e');
      return e.toString();
    }
  }

  @override
  Future<String?> getTokenForSign({ required String idUser,  required String nameDocument,  required String dataDocument}) async {
    Map<String, dynamic> data = ForGetToken.createDataToJson(id: idUser, nameDocument: nameDocument, dataDocument: dataDocument);
    try {
      final response = await http.post(
        Uri.parse(AppConfigFirmonec.instance.getUrlForSignLocal()),
        headers: {
          'Content-Type': 'application/json',
          'X-API-KEY': AppConfigFirmonec.instance.getTokenApiSignLocal()
        },
        body: json.encode(data),
      );
      print('response: ${response.body}');
      if (response.statusCode == 200 || response.statusCode == 201) {
        print("Trajo el token");
        return json.decode(response.body)["token"];
      } else {
        print("No Trajo el token");
        return null;
      }
    } catch (e) {
      print("Error $e");
      return null;
    }
  }
}