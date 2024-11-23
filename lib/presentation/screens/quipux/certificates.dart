import 'package:file_picker/file_picker.dart';
import 'package:firmonec/domain/entities/IDocument.dart';
import 'package:firmonec/presentation/screens/quipux/widget_quipux/app_bar_firmonec.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Certificates extends StatefulWidget {
  final List<IDocument> documents;
  final List<String> tokens;
  const Certificates({super.key, required this.documents, required this.tokens});

  @override
  State<Certificates> createState() => _CertificateState();
}

class _CertificateState extends State<Certificates> {
  List<String>? listCertificates;

  @override
  void initState () {
    super.initState();
  }

  Future<void> _getPathCertificates () async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      listCertificates = prefs.getStringList("certificates") ?? [];
    });
  }

  Future<void> _loadCertificate () async {
  }

  Future<void> _pickCertificate() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ["p12"]
    );

    if(result != null){
      String path = result.files.single.path!;
      await _saveCertificate(path);
    }
  }

  Future<void> _saveCertificate(String path) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      listCertificates!.add(path);
    });
    await prefs.setStringList("certificates", listCertificates!);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarFirmonec(),
      body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(24.0),
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  Icon(
                    Icons.security,
                    size: 80,
                    color: Theme.of(context).primaryColor,
                  ),
                  const SizedBox(height: 32),
                  Text(
                    "Selección de Certificados",
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Seleccione los certificados que desea utilizar para firmar documentos",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 24),
                  ListView.builder(
                    itemCount: listCertificates?.length,
                    itemBuilder: (context, index){
                      return ListTile(
                        title: Text(listCertificates![index].split("/").last),
                        trailing: IconButton(
                            onPressed: () => {},
                            icon: const Icon(Icons.file_copy_outlined)
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  Container(
                    width: double.infinity,
                    constraints: const BoxConstraints(maxWidth: 400),
                    child: ElevatedButton.icon(
                      onPressed: () => {},
                      icon: const Icon(Icons.add),
                      label: const Text("Agregar Certificado"),
                    ),
                  ),
                ],
              ),
            ),
          )
      ),
    );
  }

}