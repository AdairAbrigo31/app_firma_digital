import 'dart:typed_data';

abstract class ApiSign {

  Future<String?> getTokenForSign (String idUser, String nameDocument, String dataDocument);

  Future<Map<int, Uint8List>> getDocumentValidated(String token);

  Future<void> updateDocumentSigned(String token, Map<int, String> signedDocuments, String idUser);

}