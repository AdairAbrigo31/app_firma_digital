import 'dart:typed_data';

abstract class ApiSign {

  Future<String?> getTokenForSign ({required String nameDocument, required String dataDocument});

  Future<Map<int, Uint8List>> getDocumentValidated({required String token});

  Future<void> updateDocumentSigned({required String token, required Map<int, String> signedDocuments, required String idUser});

}