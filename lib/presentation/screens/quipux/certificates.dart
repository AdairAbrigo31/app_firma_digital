import 'package:firmonec/domain/entities/IDocument.dart';
import 'package:firmonec/presentation/screens/quipux/widget_quipux/app_bar_firmonec.dart';
import 'package:flutter/material.dart';

class Certificates extends StatefulWidget {
  final List<IDocument> documents;
  final List<String> tokens;
  const Certificates({super.key, required this.documents, required this.tokens});

  @override
  State<Certificates> createState() => _CertificateState();
}

class _CertificateState extends State<Certificates> {
  final List<String> listCertificates = [];
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return const Scaffold(
      appBar: AppBarFirmonec(),
      body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  Text("Seleccione el certificado que desea usar")
                ],
              ),
            ),
          )
      ),
    );
  }

}