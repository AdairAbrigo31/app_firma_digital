
import 'package:flutter/material.dart';
import '../../domain/entities/IDocument.dart';
import '../entities/document_en_elaboracion.dart';
import '../entities/document_reasignado.dart';

class DocumentProvider extends ChangeNotifier {
  List<IDocument> _documents = [];
  bool _isLoading = false;
  String? _error;

  List<IDocument> get documents => _documents;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get hasDocuments => _documents.isNotEmpty;

  List<DocumentEnElaboracion> get documentsTypeEnElaboracion =>
      _documents.whereType<DocumentEnElaboracion>().toList();

  List<DocumentReasignado> get documentsReasignados =>
      _documents.whereType<DocumentReasignado>().toList();

  Future<void> fetchDocuments() async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      await Future.delayed(const Duration(seconds: 2));

      final responseData = [
        {
          "title": "Documento 1",
          "subject": "Asunto del documento 1",
          "date": "2024-03-15T10:00:00Z",
          "type": "enElaboracion",
          "elaboradoPor": "Juan Pérez",
          "fechaInicio": "2024-03-14T08:00:00Z"
        },
        {
          "title": "Documento 2",
          "subject": "Asunto del documento 2",
          "date": "2024-03-16T11:00:00Z",
          "type": "reasignado",
          "reasignadoPor": "María López",
          "motivoReasignacion": "Cambio de departamento",
          "fechaReasignacion": "2024-03-15T09:00:00Z"
        },
      ];

      _documents = responseData.map((data) => IDocument.fromJson(data)).toList();

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _error = "Error: $e";
      notifyListeners();
    }
  }

  Future<void> refreshDocuments() async {
    _documents = [];
    notifyListeners();
    await fetchDocuments();
  }
}