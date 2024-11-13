import '../../domain/entities/IDocument.dart';

class DocumentEnElaboracion extends IDocument {
  final String elaboradoPor;
  final DateTime fechaInicio;

  DocumentEnElaboracion({
    required String title,
    required String subject,
    required DateTime date,
    required this.elaboradoPor,
    required this.fechaInicio,
  }) : super(
    title: title,
    subject: subject,
    date: date,
    type: 'enElaboracion',
  );

  factory DocumentEnElaboracion.fromJson(Map<String, dynamic> json) {
    return DocumentEnElaboracion(
      title: json['title'] as String,
      subject: json['subject'] as String,
      date: DateTime.parse(json['date'] as String),
      elaboradoPor: json['elaboradoPor'] as String,
      fechaInicio: DateTime.parse(json['fechaInicio'] as String),
    );
  }
}