import 'package:firmonec/domain/entities/IDocument.dart';
import 'package:flutter/material.dart';

class Certificates extends StatefulWidget {
  final List<IDocument> documents;
  final String token;
  const Certificates({super.key, required this.documents, required this.token});

  @override
  State<Certificates> createState() => _CertificateState();
}

class _CertificateState extends State<Certificates> {
  final List<String> listCertificates = [];
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return const Scaffold(
      body: Text("Certificados"),
    );
  }

}