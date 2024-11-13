import 'package:firmonec/data/entities/document_en_elaboracion.dart';
import 'package:firmonec/data/entities/document_reasignado.dart';
import 'package:flutter/cupertino.dart';
import '../../domain/entities/IDocument.dart';

class DocumentProvider extends ChangeNotifier {
  List<IDocument> _documents = [];
  bool _isLoading = false;
  String? _error;

  // Getters
  List<IDocument> get documents => _documents;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get hasDocuments => _documents.isNotEmpty;

  List<IDocument> get documentsTypeEnElaboracion => _documents.whereType<DocumentEnElaboracion>().toList();
  List<IDocument> get documentsReasignados => _documents.whereType<DocumentReasignado>().toList();

  Future<void> fetchDocuments() async {
    try{
      _isLoading = true;
      _error = null;
      notifyListeners();
      await Future.delayed(const Duration(seconds: 5));

      // Aquí iría tu llamada real al servicio
      // final response = await tuServicio.getDocuments();
      // _documents = response.map((data) => IDocument.fromJson(data)).toList();
      // la response en teoria deberia venir con los documentos en elaboracion y reasignado, aqui
      // se debe desestructurar de tal forma que a _documents vayan sólo los documentos de la response

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
    } catch (e){
      _isLoading = false;
      _error = "Error $e";
      notifyListeners();
    }
  }

  Future<void> refreshDocuments() async {
    _documents = [];
    notifyListeners();
    await fetchDocuments();
  }

  List<IDocument> getDocumentsByType(String type) {
    return _documents.where((doc) => doc.type == type).toList();
  }

}