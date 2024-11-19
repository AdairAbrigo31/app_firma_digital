import 'package:flutter/material.dart';

import '../../domain/entities/IDocument.dart';

abstract class ProviderFirmonec{
  List<IDocument> documents();
  bool isLoading();
  String? error();
  bool hasDocuments();
  Future<void> fetchDocuments ();
  Future<void> refreshDocuments();
}