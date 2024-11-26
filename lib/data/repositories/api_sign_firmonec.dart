import 'dart:convert';
import 'package:firmonec/config/config_api_sign.dart';
import 'package:firmonec/helpers/updateDocumentSignedHelper.dart';
import 'package:http/http.dart' as http;
import 'package:firmonec/domain/repositories/api_sign.dart';
import 'dart:typed_data';
import '../../helpers/getTokenForSignHelper.dart';

class ApiSignFirmonec implements ApiSign {

  @override
  Future<Map<int, Uint8List>> getDocumentValidated({required String token}) async {
    final response = await http.get(
      Uri.parse('${ConfigApiSign.instance.getUrlForSignLocal()}/$token'),
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
  Future<dynamic> updateDocumentSigned({required String token, required Map<int, String> signedDocuments, required String idUser}) async {
    try {
      List<Map<String, dynamic>> listDocuments = UpdateDocumentSignedHelper.createListWithFormat(signedDocuments: signedDocuments);
      String jsonDocuments = UpdateDocumentSignedHelper.createObjectJson(idUser: idUser, listDocuments: listDocuments);

      // Enviar la solicitud PUT al servidor
      final response = await http.put(
        Uri.parse('${ConfigApiSign.instance.getUrlForSignLocal()}/$token'),
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: {
          'json': jsonDocuments,
          'base64': base64Encode(utf8.encode(jsonDocuments)),
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
  Future<String?> getTokenForSign({required String nameDocument,  required String dataDocument}) async {
    String idUser = await GetTokenForSignHelper.getIdUser();
    Map<String, dynamic> data = GetTokenForSignHelper.createDataToJson(id: idUser, nameDocument: nameDocument, dataDocument: dataDocument);
    try {
      final response = await http.post(
        Uri.parse(ConfigApiSign.instance.getUrlForSignLocal()),
        headers: {
          'Content-Type': 'application/json',
          'X-API-KEY': ConfigApiSign.instance.getTokenApiSignLocal()
        },
        body: json.encode(data),
      );
      print("response: ${response.body}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.body;
      } else {
        return "El token no ha sido recuperado";
      }
    } catch (e) {
      print("Error $e");
      return null;
    }
  }
}