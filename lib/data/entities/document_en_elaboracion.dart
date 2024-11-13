import 'package:firmonec/domain/entities/IDocument.dart';

class DocumentEnElaboracion extends IDocument {
  final String elaboradoPor;
  final DateTime fechaInicio;

  DocumentEnElaboracion({
    required super.title,
    required super.subject,
    required super.date,
    required this.elaboradoPor,
    required this.fechaInicio
  }) : super (type: "enElaboracion");


  factory DocumentEnElaboracion.fromJson(Map<String, dynamic> json) {
    return DocumentEnElaboracion(
      title: json['title'],
      subject: json['subject'],
      date: DateTime.parse(json['date']),
      elaboradoPor: json['elaboradoPor'],
      fechaInicio: DateTime.parse(json['fechaInicio']),
    );
  }
}