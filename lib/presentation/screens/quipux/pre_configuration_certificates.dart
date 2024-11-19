import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreConfigurationCertificate extends StatefulWidget {
  const PreConfigurationCertificate({super.key});

  @override
  State<PreConfigurationCertificate> createState() {
    return _PreConfigurationCertificateState();
  }
}

class _PreConfigurationCertificateState extends State<PreConfigurationCertificate> {
  List<String> selectedCertificates = [];

  @override
  void initState(){
    super.initState();
    _loadCertificates();
  }

  Future<void> _loadCertificates() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedCertificates = prefs.getStringList("certificates") ?? [];
    });
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
      selectedCertificates.add(path);
    });
    await prefs.setStringList("certificates", selectedCertificates);
  }

  void _removeCertificate(int index) async {
    final prefes = await SharedPreferences.getInstance();
    setState(() {
      selectedCertificates.removeAt(index);
    });
    await prefes.setStringList("certificates", selectedCertificates);
  }

  void _onSubmit(){
    if(selectedCertificates.isNotEmpty) {
      Navigator.pushReplacementNamed(context, "/documents_for_sign");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
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
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: selectedCertificates.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(selectedCertificates[index].split('/').last),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => _removeCertificate(index),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  constraints: const BoxConstraints(maxWidth: 400),
                  child: ElevatedButton.icon(
                    onPressed: _pickCertificate,
                    icon: const Icon(Icons.add),
                    label: const Text("Agregar Certificado"),
                  ),
                ),
                const SizedBox(height: 32),
                Container(
                  width: double.infinity,
                  constraints: const BoxConstraints(maxWidth: 400),
                  child: ElevatedButton(
                    onPressed: selectedCertificates.isEmpty ? null : _onSubmit,
                    child: const Text(
                      "Continuar",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}