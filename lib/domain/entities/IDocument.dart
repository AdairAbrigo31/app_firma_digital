import '../../data/entities/document_en_elaboracion.dart';
import '../../data/entities/document_reasignado.dart';
import 'dart:typed_data';

abstract class IDocument {
  final String title;
  final String subject;
  final DateTime date;
  final String type;
  final String dataInBase64;

  IDocument({
    required this.title,
    required this.subject,
    required this.date,
    required this.type,
    required this.dataInBase64
  });

  factory IDocument.fromJson(Map<String, dynamic> json) {
    final type = json['type'] as String;

    switch (type) {
      case 'enElaboracion':
        return DocumentEnElaboracion.fromJson(json);
      case 'reasignado':
        return DocumentReasignado.fromJson(json);
      default:
        throw Exception('Tipo de documento no soportado: $type');
    }
  }
}