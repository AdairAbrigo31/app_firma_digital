class ForGetToken {

  static Map<String, dynamic> createDataToJson({required String id, required String nameDocument, required String dataDocument}){
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