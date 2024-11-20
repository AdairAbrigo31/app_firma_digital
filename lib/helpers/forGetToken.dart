import 'package:shared_preferences/shared_preferences.dart';

class ForGetToken {

  static Map<String, dynamic> createDataToJson({required String id, required String nameDocument, required String dataDocument}) {
    //Establecemos el id aqui ya que la aplicación tiene el objetivo que los documentos que firme sólo sean los del usuario que realizo el preregistro

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