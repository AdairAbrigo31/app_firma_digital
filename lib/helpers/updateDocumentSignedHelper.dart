import 'dart:convert';

class UpdateDocumentSignedHelper {

  static List<Map<String, dynamic>> createListWithFormat({required Map<int, String> signedDocuments}) {
    List<Map<String, dynamic>> listDocuments = [];
    signedDocuments.forEach((id, base64) {
      if (base64.isNotEmpty) {
        listDocuments.add({
          'id': id,
          'documento': base64,
        });
      }
    });

    return listDocuments;
  }

  static String createObjectJson({required String idUser, required List<Map<String, dynamic>> listDocuments}){
  Map<String, dynamic> jsonMap = {
    'cedula': idUser,
    'documentos': listDocuments,
  };
  String jsonDocuments = jsonEncode(jsonMap);

  return jsonDocuments;
  }
}