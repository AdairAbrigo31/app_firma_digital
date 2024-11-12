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

  Future<void> fetchDocuments() async {
    try{
      _isLoading = true;
      _error = null;
      notifyListeners();
      await Future.delayed(const Duration(seconds: 5));
      // Aquí iría tu llamada real al servicio
      // final response = await tuServicio.getDocuments();
      // _documents = response.map((data) => Document.fromJson(data)).toList();
      // la response en teoria deberia venir con los documentos en elaboracion y reasignado, aqui
      // se debe desestructurar de tal forma que a _documents vayan sólo los documentos de la response
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

}