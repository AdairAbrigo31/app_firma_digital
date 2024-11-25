
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../config/app_config_firmonec.dart';

class Step1ForSignFirmonec {
  static Future<String> _getIdUser () async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("idUser")!;
  }

  static Map<String, dynamic> _createDataToJson({required String id, required String nameDocument, required String dataDocument}) {
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

  Future<String?> getTokenForSign({required String nameDocument,  required String dataDocument}) async {
    String idUser = await _getIdUser();
    Map<String, dynamic> data = _createDataToJson(id: idUser, nameDocument: nameDocument, dataDocument: dataDocument);
    try {
      final response = await http.post(
        Uri.parse(AppConfigFirmonec.instance.getUrlForSignLocal()),
        headers: {
          'Content-Type': 'application/json',
          'X-API-KEY': AppConfigFirmonec.instance.getTokenApiSignLocal()
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