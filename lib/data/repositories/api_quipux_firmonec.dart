import 'dart:convert';
import 'package:firmonec/config/config_api.dart';
import 'package:http/http.dart' as http;

class ApiQuipuxFirmonec{

  static Map<String, dynamic> _createDataToJson({required String id, required String nameDocument, required String dataDocument}){
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

  static Future<String?> _validateToken ({required Map<String, dynamic> data}) async {
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

  static Future<String?> getToken({required String id, required String nameDocument, required String dataDocument}) async {
    Map<String, dynamic> data = await _createDataToJson(id: id, nameDocument: nameDocument, dataDocument: dataDocument);
    return await _validateToken(data: data);
  }

}