import '../../domain/entities/IDocument.dart';

class DocumentReasignado extends IDocument {
  final String reasignadoPor;
  final String motivoReasignacion;
  final DateTime fechaReasignacion;

  DocumentReasignado({
    required super.title,
    required super.subject,
    required super.date,
    required this.reasignadoPor,
    required this.motivoReasignacion,
    required this.fechaReasignacion,
  }) : super(type: 'reasignado');

  factory DocumentReasignado.fromJson(Map<String, dynamic> json) {
    return DocumentReasignado(
      title: json['title'],
      subject: json['subject'],
      date: DateTime.parse(json['date']),
      reasignadoPor: json['reasignadoPor'],
      motivoReasignacion: json['motivoReasignacion'],
      fechaReasignacion: DateTime.parse(json['fechaReasignacion']),
    );
  }
}
