import '../../data/entities/document_en_elaboracion.dart';
import '../../data/entities/document_reasignado.dart';

abstract class IDocument {
  final String title;
  final String subject;
  final DateTime date;
  final String type;

  IDocument({
    required this.title,
    required this.subject,
    required this.date,
    required this.type
  });

  factory IDocument.fromJson(Map<String, dynamic> json) {
    final String type = json["Type"];
    switch (type) {
      case "enElaboracion":
        return DocumentEnElaboracion.fromJson(json);
      case "reasignado":
        return DocumentReasignado.fromJson(json);
      default:
        throw Exception("Tipo de documento no soportado: $type");
    }
  }

}