import 'dart:typed_data';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'dart:ui';
import 'dart:convert';

Future<Map<int, String>> signDocument(
    Map<int, Uint8List> documents, // El mapa utiliza int como clave
    File certificado,
    String password,
    ) async {
  Map<int, String> documentosFirmados = {};
  Uint8List? imageBytes;
  final ByteData imageData = await rootBundle.load('assets/image.png');
  imageBytes = imageData.buffer.asUint8List();

  for (int id in documents.keys) {
    try {
      Uint8List documentoBytes = documents[id]!;

      // Cargar el documento PDF original
      var documentoPdf = PdfDocument(inputBytes: documentoBytes);

      // Seleccionar la primera página para firmar
      final PdfPage page = documentoPdf.pages[0];

      // Obtener las dimensiones de la página
      double pageWidth = page.getClientSize().width;
      double pageHeight = page.getClientSize().height;

      // Ajustar el tamaño y posicionamiento del cuadro de firma
      double signatureFieldWidth = 200;
      double signatureFieldHeight = 100;

      double xPosition = (pageWidth - signatureFieldWidth) / 2; // Centrar horizontalmente
      double yPosition = pageHeight - signatureFieldHeight - 10; // Margen desde el borde inferior

      // Crear el campo de firma en la parte inferior de la página
      PdfSignatureField field = PdfSignatureField(
        page,
        'signature',
        bounds: Rect.fromLTWH(xPosition, yPosition, signatureFieldWidth, signatureFieldHeight),
        signature: PdfSignature(
          certificate: PdfCertificate(certificado.readAsBytesSync(), password),
          contactInfo: 'email@test.com',
          locationInfo: 'Ecuador, Guayaquil',
          reason: 'FirmaEC',
          digestAlgorithm: DigestAlgorithm.sha256,
          cryptographicStandard: CryptographicStandard.cms,
        ),
      );

      // Añadir el campo de firma al documento
      documentoPdf.form.fields.add(field);

      // Dibujar la imagen del QR en la parte inferior dentro del cuadro de firma
      PdfGraphics? graphics = field.appearance.normal.graphics;
      if (graphics != null) {
        double qrWidth = 50;
        double qrHeight = 50;

        // Posicionar el QR en la parte inferior dentro del cuadro de firma
        double qrXPosition = (signatureFieldWidth - qrWidth) / 2; // Centrar dentro del cuadro de firma
        double qrYPosition = (signatureFieldHeight - qrHeight) / 2; // Centrar verticalmente dentro del cuadro

        graphics.drawImage(
          PdfBitmap(imageBytes),
          Rect.fromLTWH(qrXPosition, qrYPosition, qrWidth, qrHeight),
        );
      }

      // Guardar el documento firmado
      List<int> bytes = await documentoPdf.save();
      documentoPdf.dispose();

      // Convertir a base64 y añadir al mapa de documentos firmados
      String signedDocumentBase64 = base64Encode(Uint8List.fromList(bytes));
      documentosFirmados[id] = signedDocumentBase64;

      print('Documento con ID $id firmado exitosamente.');
    } catch (ex) {
      print('Fallo al hacer el signedDocument $id: $ex');
      // No se agrega al mapa si no se firma
    }
  }

  return documentosFirmados;
}
