import 'dart:async';
import 'package:firmonec/data/providers/document_provider.dart';
import 'package:firmonec/presentation/screens/quipux/widget_quipux/app_bar_firmonec.dart';
import 'package:firmonec/presentation/screens/quipux/widget_quipux/charge_card.dart';
import 'package:firmonec/presentation/screens/quipux/widget_quipux/document_card.dart';
import 'package:firmonec/presentation/screens/quipux/widget_quipux/empty_card.dart';
import 'package:firmonec/presentation/screens/quipux/widget_quipux/error_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../data/entities/document_en_elaboracion.dart';
import '../../../data/entities/document_reasignado.dart';
import '../../../domain/entities/IDocument.dart';

class DocumentsForSign extends StatefulWidget {
  const DocumentsForSign({super.key});

  @override
  State<DocumentsForSign> createState() => _DocumentsForSignState();
}

class _DocumentsForSignState extends State<DocumentsForSign> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    Future.microtask(
          () => context.read<DocumentProvider>().fetchDocuments(),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
      ChangeNotifierProvider(create: (_) => DocumentProvider()),
      ],
      child: Scaffold(
        appBar: AppBarFirmonec(),
        body: Consumer<DocumentProvider>(
          builder: (context, provider, child) {
            if (provider.isLoading() && !provider.hasDocuments()) {
              return const ChargeCard();
            }

            if (provider.error() != null) {
              return ErrorCard(provider: provider);
            }

            if (!provider.hasDocuments()) {
              return EmptyCard(provider: provider);
            }

            return Stack(
              children: [
                RefreshIndicator(
                  onRefresh: provider.refreshDocuments,
                  child: ListView.builder(
                    controller: _scrollController,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: provider.documents().length,
                    itemBuilder: (context, index) {
                      return DocumentCard(
                        document: provider.documents()[index],
                        onTap: () {
                          // Manejar el tap en el documento
                          _showDocumentDetails(context, provider.documents()[index]);
                        },
                      );
                    },
                  ),
                ),
                if (provider.isLoading())
                  const Positioned(
                    top: 20,
                    right: 20,
                    child: CircularProgressIndicator(),
                  ),
              ],
            );
          },
        ),
      )
    );
  }

  void _showDocumentDetails(BuildContext context, IDocument document) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.5,
        minChildSize: 0.3,
        maxChildSize: 0.9,
        expand: false,
        builder: (context, scrollController) => SingleChildScrollView(
          controller: scrollController,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    margin: const EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                Text(
                  document.title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  document.subject,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 16),
                // Aquí puedes agregar más detalles según el tipo de documento
                if (document is DocumentEnElaboracion) ...[
                  _buildDetailRow('Elaborado por:', document.elaboradoPor),
                  _buildDetailRow('Fecha de inicio:', _formatDate(document.fechaInicio)),
                ],
                if (document is DocumentReasignado) ...[
                  _buildDetailRow('Reasignado por:', document.reasignadoPor),
                  _buildDetailRow('Motivo:', document.motivoReasignacion),
                  _buildDetailRow('Fecha de reasignación:', _formatDate(document.fechaReasignacion)),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}