import 'package:firmonec/data/providers/IProvider.dart';
import 'package:firmonec/domain/entities/IDocument.dart';
import 'package:flutter/material.dart';

class Demo2Provider extends ChangeNotifier implements ProviderFirmonec {
  @override
  List<IDocument> documents() {
    // TODO: implement documents
    throw UnimplementedError();
  }

  @override
  String error() {
    // TODO: implement error
    throw UnimplementedError();
  }

  @override
  Future<void> fetchDocuments() {
    // TODO: implement fetchDocuments
    throw UnimplementedError();
  }

  @override
  bool hasDocuments() {
    // TODO: implement hasDocuments
    throw UnimplementedError();
  }

  @override
  bool isLoading() {
    // TODO: implement isLoading
    throw UnimplementedError();
  }

  @override
  Future<void> refreshDocuments() {
    // TODO: implement refreshDocuments
    throw UnimplementedError();
  }

}