import 'package:shared_preferences/shared_preferences.dart';

class GetTokenForSignHelper {

  static Future<String> getIdUser () async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("idUser")!;
  }

  static Map<String, dynamic> createDataToJson({required String id, required String nameDocument, required String dataDocument}) {
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
}