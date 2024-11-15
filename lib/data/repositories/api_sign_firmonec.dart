import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:firmonec/domain/repositories/api_sign.dart';
import '../../config/config_api.dart';
import 'dart:typed_data';

class ApiSignFirmonec implements ApiSign {

  Map<String, dynamic> _createDataToJson({required String id, required String nameDocument, required String dataDocument}){
    final data = {
      'cedula': id,
      'sistema': 'quipux',
      'documentos': [
        {
          'nombre': nameDocument,
          'documento': dataDocument,
        },
      ],
    };
    return data;
  }

  Future<String?> _validateToken ({required Map<String, dynamic> data}) async {
    final response = await http.post(
      Uri.parse(AppConfig.instance.getUrlServer()),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    );
    if (response.statusCode == 200) {
      print("Validacion  correcta ");
      return json.decode(response.body)['token'];
    } else {
      return null;
    }
  }

  @override
  Future<String?> getTokenForSign(String idUser, String nameDocument, String dataDocument) async {
    Map<String, dynamic> data = await _createDataToJson(id: idUser, nameDocument: nameDocument, dataDocument: dataDocument);
    return await _validateToken(data: data);
  }


  @override
  Future<Map<int, Uint8List>> getDocumentValidated(String token) async {
    final response = await http.get(
      Uri.parse('${AppConfig.instance.getUrlFirmonec()}/$token'),
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
        Uri.parse('${AppConfig.instance.getUrlFirmonec()}/$token'),
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: {
          'json': jsonDocumentos,
          'base64': base64Encode(utf8.encode(jsonDocumentos)),
        },
      );
      if (response.statusCode == 200) {
        print('Documento recibido: ${response.body}');
        // try {
        //   final documentoJson = json.decode(response.body);
        //   print('Documento como JSON: $documentoJson');
        // } catch (e) {
        //   print('Error al decodificar el JSON: $e');
        // }
        return true;
      } else {
        // print('Error al actualizar los documentos: ${response.statusCode}');
        // print('Respuesta del servidor: ${response.body}');
        return false;
      }
    } catch (e) {
      // print('Error en actualizarDocumento: $e');
      return e.toString();
    }
  }
}