import 'package:flutter/material.dart';

import '../entities/IDocument.dart';

abstract class IProvider{
  List<IDocument> documents();
  bool isLoading();
  String? error();
  bool hasDocuments();
  Future<void> fetchDocuments ();
  Future<void> refreshDocuments();
}