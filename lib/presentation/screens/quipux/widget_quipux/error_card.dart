import 'package:firmonec/domain/repositories/IProvider.dart';
import 'package:firmonec/data/providers/document_provider.dart';
import 'package:flutter/material.dart';

class ErrorCard extends StatelessWidget {
  final IProvider provider;

  const ErrorCard({super.key, required this.provider});

  @override
  Widget build(BuildContext context) {
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
            // Es mejor agregar una verificación en caso de que error sea null
            provider.error() ?? 'Ha ocurrido un error',
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.red),
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: () => provider.fetchDocuments(),
            icon: const Icon(Icons.refresh),
            label: const Text('Reintentar'),
          ),
        ],
      ),
    );
  }
}