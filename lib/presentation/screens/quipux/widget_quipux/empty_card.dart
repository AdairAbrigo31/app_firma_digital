import 'package:firmonec/domain/repositories/IProvider.dart';
import 'package:firmonec/data/providers/document_provider.dart';
import 'package:flutter/material.dart';

class EmptyCard extends StatelessWidget {
  final IProvider provider;

  const EmptyCard({super.key, required this.provider});



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.document_scanner_outlined,
            size: 64,
            color: Colors.grey,
          ),
          const SizedBox(height: 16),
          const Text(
            'No hay documentos disponibles',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: () => provider.refreshDocuments(),
            icon: const Icon(Icons.refresh),
            label: const Text('Actualizar'),
          ),
        ],
      ),
    );
  }

}