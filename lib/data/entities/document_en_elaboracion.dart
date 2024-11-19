import '../../domain/entities/IDocument.dart';
import 'dart:typed_data';

class DocumentEnElaboracion extends IDocument {
  final String elaboradoPor;
  final DateTime fechaInicio;

  DocumentEnElaboracion({
    required super.title,
    required super.subject,
    required super.date,
    required super.dataInBytes,
    required this.elaboradoPor,
    required this.fechaInicio,
  }) : super(
    type: 'enElaboracion',
  );

  factory DocumentEnElaboracion.fromJson(Map<String, dynamic> json) {
    return DocumentEnElaboracion(
      title: json['title'] as String,
      subject: json['subject'] as String,
      date: DateTime.parse(json['date'] as String),
      elaboradoPor: json['elaboradoPor'] as String,
      fechaInicio: DateTime.parse(json['fechaInicio'] as String),
      dataInBytes: json['dataInBytes'] as String,
    );
  }
}