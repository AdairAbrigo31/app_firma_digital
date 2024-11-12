import 'dart:async';

import 'package:firmonec/data/providers/document_provider.dart';
import 'package:firmonec/presentation/screens/quipux/widget_quipux/document_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DocumentsForSign extends StatefulWidget {
  const DocumentsForSign({super.key});

  @override
  State<DocumentsForSign> createState() => _DocumentsForSignState();
}

class _DocumentsForSignState extends State<DocumentsForSign>{
  @override
  void initState() {
    super.initState();
    Future.microtask(
            () => context.read<DocumentProvider>().fetchDocuments(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DocumentProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (provider.error != null) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.error_outline,
                  color: Colors.red,
                  size: 48,
                ),
                const SizedBox(height: 16),
                Text(
                  provider.error!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.red),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => provider.fetchDocuments(),
                  child: const Text('Reintentar'),
                ),
              ],
            ),
          );
        }

        if (!provider.hasDocuments) {
          return const Center(
            child: Text('No hay documentos disponibles'),
          );
        }

        return RefreshIndicator(
          onRefresh: provider.refreshDocuments,
          child: ListView.builder(
            itemCount: provider.documents.length,
            itemBuilder: (context, index) {
              return DocumentCard(
                document: provider.documents[index],
                onTap: () {
                  // Manejar el tap en el documento
                  print('Documento seleccionado: ${provider.documents[index]}');
                },
              );
            },
          ),
        );
      },
    );
  }
}