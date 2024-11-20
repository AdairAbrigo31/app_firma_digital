
import 'dart:convert';
import 'package:firmonec/domain/repositories/IProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../domain/entities/IDocument.dart';


class DemoProvider extends ChangeNotifier implements ProviderFirmonec{
  List<IDocument> _documents = [];
  bool _isLoading = false;
  String? _error;

  Future<String> _getPdfAsBase64() async {
    try {
      final ByteData bytes = await rootBundle.load('assets/CV_Abrigo.pdf');
      final Uint8List list = bytes.buffer.asUint8List();
      return base64Encode(list); // Convertir a base64 para JSON
    } catch (e) {
      throw Exception('Error al cargar el PDF: $e');
    }
  }

  @override
  List<IDocument> documents() => _documents;
  @override
  bool isLoading() => _isLoading;
  @override
  String? error() => _error;
  @override
  bool hasDocuments() => _documents.isNotEmpty;

  @override
  Future<void> fetchDocuments() async {
    try {
      _isLoading = true;
      _error = null;
      await Future.delayed(const Duration(seconds: 1));
      String pdfBase64 = await _getPdfAsBase64();

      final responseData = [
        {
          "title": "Documento 1",
          "subject": "Asunto del documento 1",
          "date": "2024-03-15T10:00:00Z",
          "type": "enElaboracion",
          "elaboradoPor": "Juan Pérez",
          "fechaInicio": "2024-03-14T08:00:00Z",
          "dataInBase64": pdfBase64

        },
        {
          "title": "Documento 2",
          "subject": "Asunto del documento 2",
          "date": "2024-03-16T11:00:00Z",
          "type": "reasignado",
          "reasignadoPor": "María López",
          "motivoReasignacion": "Cambio de departamento",
          "fechaReasignacion": "2024-03-15T09:00:00Z",
          "dataInBase64": pdfBase64
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

  @override
  Future<void> refreshDocuments() async {
    _documents = [];
    notifyListeners();
    await fetchDocuments();
  }
}