import 'dart:io';
import 'package:firmonec/domain/entities/IDocument.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Certificates extends StatefulWidget {
  final List<IDocument> documents;
  final List<String> tokens;
  const Certificates({super.key, required this.documents, required this.tokens});

  @override
  State<Certificates> createState() => _CertificatesState();
}

class _CertificatesState extends State<Certificates> {
  List<String> certificates = [];
  Set<int> selectedDocuments = {};
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadCertificates();
  }

  Future<void> _loadCertificates() async {
    final prefs = await SharedPreferences.getInstance();
    final savedCertificates = prefs.getStringList("certificates") ?? [];

    // Validar que los certificados existan
    final validCertificates = <String>[];
    for (final path in savedCertificates) {
      if (await File(path).exists()) {
        validCertificates.add(path);
      }
    }

    setState(() {
      certificates = validCertificates;
      isLoading = false;
    });
  }

  void _toggleDocumentSelection(int index) {
    setState(() {
      if (selectedDocuments.contains(index)) {
        selectedDocuments.remove(index);
      } else {
        selectedDocuments.add(index);
      }
    });
  }

  void _onSignSelected() {
    if (selectedDocuments.isEmpty) return;

    // Aquí iría la lógica para procesar los documentos seleccionados
    final selectedPaths = selectedDocuments
        .map((index) => certificates[index])
        .toList();

    // TODO: Implementar la acción de firma
    print('Documentos seleccionados: $selectedPaths');
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
                  Icons.description,
                  size: 80,
                  color: Theme.of(context).primaryColor,
                ),
                const SizedBox(height: 32),
                Text(
                  "Certificados Disponibles",
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  "Seleccione los certificados que desea procesar",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 24),
                if (isLoading)
                  const CircularProgressIndicator()
                else if (certificates.isEmpty)
                  Center(
                    child: Column(
                      children: [
                        Icon(
                          Icons.no_sim,
                          size: 48,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          "No hay certificados disponibles",
                          style: TextStyle(
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  )
                else
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: certificates.length,
                    itemBuilder: (context, index) {
                      final fileName = certificates[index].split('/').last;
                      final isSelected = selectedDocuments.contains(index);

                      return Card(
                        elevation: isSelected ? 2 : 1,
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        color: isSelected
                            ? Theme.of(context).primaryColor.withOpacity(0.1)
                            : null,
                        child: ListTile(
                          leading: Icon(
                            Icons.file_present,
                            color: isSelected
                                ? Theme.of(context).primaryColor
                                : Colors.grey,
                          ),
                          title: Text(
                            fileName,
                            style: TextStyle(
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                          trailing: isSelected
                              ? Icon(
                            Icons.check_circle,
                            color: Theme.of(context).primaryColor,
                          )
                              : const Icon(
                            Icons.radio_button_unchecked,
                            color: Colors.grey,
                          ),
                          onTap: () => _toggleDocumentSelection(index),
                        ),
                      );
                    },
                  ),
                const SizedBox(height: 32),
                Container(
                  width: double.infinity,
                  constraints: const BoxConstraints(maxWidth: 400),
                  child: ElevatedButton(
                    onPressed: selectedDocuments.isEmpty ? null : _onSignSelected,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: Text(
                      selectedDocuments.isEmpty
                          ? "Seleccione al menos un certificado"
                          : "Procesar ${selectedDocuments.length} certificado${selectedDocuments.length == 1 ? '' : 's'}",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  constraints: const BoxConstraints(maxWidth: 400),
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                          context,
                          "/pre_configuration"
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text(
                      "Volver a configuración",
                      style: TextStyle(
                        fontSize: 16,
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