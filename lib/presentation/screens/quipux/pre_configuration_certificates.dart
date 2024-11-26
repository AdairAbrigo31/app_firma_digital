import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firmonec/config/config_persistence_data.dart';
import 'package:firmonec/domain/repositories/i_config_persistence_data.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart' as path;

class PreConfigurationCertificate extends StatefulWidget {
  const PreConfigurationCertificate({super.key});

  @override
  State<PreConfigurationCertificate> createState() {
    return _PreConfigurationCertificateState();
  }
}

class _PreConfigurationCertificateState extends State<PreConfigurationCertificate> {
  final IConfigPersistenceData configPersistenceData = ConfigPersistenceData.instance;
  List<String> selectedCertificates = [];

  @override
  void initState(){
    super.initState();
    _loadCertificates();
  }

  Future<bool> _validateCertificatePath(String path) async {
    final file = File(path);
    return await file.exists();
  }

  Future<void> _loadCertificates() async {
    final prefs = await SharedPreferences.getInstance();
    final savedCertificates = await configPersistenceData.getCertificatesInPersistence() ?? [];

    // Filtrar solo los certificados que aún existen
    final validCertificates = <String>[];
    for (final path in savedCertificates) {
      if (await _validateCertificatePath(path)) {
        validCertificates.add(path);
      }
    }

    setState(() {
      selectedCertificates = validCertificates;
    });

    // Actualizar SharedPreferences si algunos certificados ya no existen
    if (validCertificates.length != savedCertificates.length) {
      await prefs.setStringList("certificates", validCertificates);
    }
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

  Future<void> _saveCertificate(String originalPath) async {
    try {
      final appDir = await getApplicationDocumentsDirectory();
      final fileName = path.basename(originalPath);
      final localPath = path.join(appDir.path, 'certificates', fileName);
      final certificateDir = Directory(path.dirname(localPath));
      if(!await certificateDir.exists()){
        await certificateDir.create(recursive: true);
      }
      final File originalFile = File(originalPath);
      await originalFile.copy(localPath);
      final prefs = await SharedPreferences.getInstance();
      setState(() {
        selectedCertificates.add(localPath);
      });
      await prefs.setStringList("certificates", selectedCertificates);
    } catch (e) {
      // Manejar el error apropiadamente
      print('Error al guardar el certificado: $e');
      // Aquí deberías mostrar un mensaje al usuario
    }
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