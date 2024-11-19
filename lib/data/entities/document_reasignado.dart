import '../../domain/entities/IDocument.dart';

class DocumentReasignado extends IDocument {
  final String reasignadoPor;
  final String motivoReasignacion;
  final DateTime fechaReasignacion;

  DocumentReasignado({
    required super.title,
    required super.subject,
    required super.date,
    required super.dataInBytes,
    required this.reasignadoPor,
    required this.motivoReasignacion,
    required this.fechaReasignacion
  }) : super(
    type: 'enElaboracion',
  );

  factory DocumentReasignado.fromJson(Map<String, dynamic> json) {
    return DocumentReasignado(
      title: json['title'] as String,
      subject: json['subject'] as String,
      date: DateTime.parse(json['date'] as String),
      reasignadoPor: json['reasignadoPor'] as String,
      motivoReasignacion: json['motivoReasignacion'] as String,
      fechaReasignacion: DateTime.parse(json['fechaReasignacion'] as String),
      dataInBytes: json['dataInBytes'] as String,
    );
  }
}