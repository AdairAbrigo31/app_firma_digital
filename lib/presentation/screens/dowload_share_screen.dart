import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:convert';
import 'package:path/path.dart' as path;

class DowloadShareScreen extends StatelessWidget {
  final Map<int, String> signedDocuments;

  const DowloadShareScreen({
    Key? key,
    required this.signedDocuments,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Documentos Firmados'),
        actions: [
          // Botón para descargar todos los documentos
          if (signedDocuments.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.arrow_downward_rounded),
              onPressed: () => _downloadAllDocuments(signedDocuments),
              tooltip: 'Descargar todos',
            ),
        ],
      ),
      body: signedDocuments.isEmpty
          ? const Center(
        child: Text(
          'No hay documentos firmados',
          style: TextStyle(fontSize: 16),
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: signedDocuments.length,
        itemBuilder: (context, index) {
          final id = signedDocuments.keys.elementAt(index);
          return Card(
            elevation: 2,
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              leading: const Icon(
                Icons.file_present,
                size: 40,
                color: Colors.blue,
              ),
              title: Text(
                'Documento $id',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              subtitle: const Text('PDF Firmado'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Botón de descarga individual
                  IconButton(
                    icon: const Icon(Icons.download),
                    onPressed: () => _dowloadIndividualDocument(id),
                    tooltip: 'Descargar',
                  ),
                  // Botón de compartir
                  IconButton(
                    icon: const Icon(Icons.share),
                    onPressed: () => _shareDocument(id),
                    tooltip: 'Compartir',
                  ),
                ],
              ),
            ),
          );
        },
      ),
      // Botón flotante para descargar todos
      floatingActionButton: signedDocuments.isEmpty
          ? null
          : FloatingActionButton.extended(
        onPressed: () => _downloadAllDocuments(signedDocuments),
        label: const Text('Descargar Todos'),
        icon: const Icon(Icons.download),
      ),
    );
  }

  Future<void> _dowloadIndividualDocument(int id) async {
    final documentoIndividual = <int, String>{id: signedDocuments[id]!};
    await _downloadAllDocuments(documentoIndividual);
  }

  Future<void> _shareDocument(int id) async {
    try {
      // Crear archivo temporal para compartir
      final tempDir = await getTemporaryDirectory();
      final tempFile = File('${tempDir.path}/documento_firmado_$id.pdf');

      // Decodificar y escribir el archivo
      final bytes = base64Decode(signedDocuments[id]!);
      await tempFile.writeAsBytes(bytes);

      // Compartir el archivo
      await Share.shareXFiles(
        [XFile(tempFile.path)],
        subject: 'Documento Firmado $id',
      );

      // Opcional: Eliminar el archivo temporal después de compartir
      await tempFile.delete();
    } catch (e) {
      print('Error al compartir el documento: $e');
    }
  }


  Future<void> _downloadAllDocuments(Map<int, String> signedDocuments) async {
    try {
      // Solicitar al usuario que seleccione la carpeta de destino
      String? directoryPath = await FilePicker.platform.getDirectoryPath(
        dialogTitle: 'Seleccione donde guardar los documentos firmados',
      );

      if (directoryPath == null) {
        print('Selección de carpeta cancelada por el usuario');
        return;
      }

      // Contador para mostrar progreso
      int totalDocumentos = signedDocuments.length;
      int documentosGuardados = 0;

      // Procesar cada documento
      for (var entry in signedDocuments.entries) {
        try {
          int idDocumento = entry.key;
          String base64Document = entry.value;

          // Decodificar el documento de base64 a bytes
          List<int> bytes = base64Decode(base64Document);

          // Crear el nombre del archivo
          String fileName = 'documento_firmado_$idDocumento.pdf';
          String filePath = path.join(directoryPath, fileName);

          // Escribir el archivo
          await File(filePath).writeAsBytes(bytes);

          documentosGuardados++;
          print('Documento $idDocumento guardado exitosamente (${documentosGuardados}/$totalDocumentos)');

        } catch (e) {
          print('Error al guardar el documento ${entry.key}: $e');
        }
      }

      if (documentosGuardados == totalDocumentos) {
        print('Todos los documentos fueron guardados exitosamente en: $directoryPath');
      } else {
        print('Se guardaron $documentosGuardados de $totalDocumentos documentos');
      }

    } catch (e) {
      print('Error en el proceso de descarga: $e');
    }
  }

}