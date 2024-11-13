import '../../domain/entities/IDocument.dart';

class DocumentReasignado extends IDocument {
  final String reasignadoPor;
  final String motivoReasignacion;
  final DateTime fechaReasignacion;

  DocumentReasignado({
    required String title,
    required String subject,
    required DateTime date,
    required this.reasignadoPor,
    required this.motivoReasignacion,
    required this.fechaReasignacion,
  }) : super(
    title: title,
    subject: subject,
    date: date,
    type: 'reasignado',
  );

  factory DocumentReasignado.fromJson(Map<String, dynamic> json) {
    return DocumentReasignado(
      title: json['title'] as String,
      subject: json['subject'] as String,
      date: DateTime.parse(json['date'] as String),
      reasignadoPor: json['reasignadoPor'] as String,
      motivoReasignacion: json['motivoReasignacion'] as String,
      fechaReasignacion: DateTime.parse(json['fechaReasignacion'] as String),
    );
  }
}