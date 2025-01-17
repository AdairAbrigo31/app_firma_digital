
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:firmonec/data/repositories/api_quipux_espol.dart';
import 'package:firmonec/data/repositories/api_sign_firmonec.dart';
import 'package:firmonec/domain/repositories/api_quipux.dart';
import 'package:firmonec/domain/repositories/api_sign.dart';
import 'package:firmonec/helpers/pickfile_custom.dart';
import 'package:firmonec/helpers/sign_document.dart';
import 'package:firmonec/presentation/screens/without_quipux/dowload_share_screen.dart';
import 'package:firmonec/presentation/widgets_app/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class SignedFree extends StatefulWidget {
  final ApiQuipux apiQuipux = new ApiQuipuxEspol();
  SignedFree({super.key});

  @override
  SignedFreeState createState() => SignedFreeState();

}

class SignedFreeState extends State<SignedFree>{
  final ApiSign apiSign = ApiSignFirmonec();

  final _cedulaController = TextEditingController();
  String? _documentData;
  String? _documentName;
  Uint8List? _documentBytes;
  String? _documentPath; // Definir la variable de instancia aquí
  bool _isDocumentSelected = false;
  final PdfViewerController _pdfViewerController = PdfViewerController();
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
  File? certifiedFile;
  bool _passCertified = false;
  String? _tokenPassDocument;
  String? _password;

  Future<void> onSubmitPDF() async {
    final fileData = await pickFile();
    if (fileData != null) {
      setState(() {
        _documentData = fileData['fileBase64'];
        _documentName = fileData['fileName'];
        _documentBytes = base64Decode(_documentData!);
        _documentPath = fileData['filePath']; // Captura la ruta del archivo cargado
        _isDocumentSelected = true;
      });
    }
  }

  Future<void> validatedDocument() async {
    if (_cedulaController.text.isNotEmpty && _documentData != null &&
        _documentName != null) {
      String? token = await apiSign.getTokenForSign(nameDocument: _documentName!, dataDocument: _documentData!);
      if (token != null) {
        _tokenPassDocument = token;
        setState(() {
          _passCertified = true;
        });
      } else {
        print("Error al cargar el documento");
      }
    }
  }

  Future<void> onSubmitCertified() async{
    FilePickerResult? certifiedInformation = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['p12']
    );

    if(certifiedInformation != null){
      certifiedFile = File(certifiedInformation.files.single.path!);
      showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text("Contraseña"),
            content: TextField(
              controller: TextEditingController(),
              obscureText: true,
              onChanged: (value) => {
                _password = value
              }
              ),
            actions: [
              TextButton(
                  onPressed: onSignDocument,
                  child: Text("Firmar documento")
              )
            ],
          )
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No se seleccionó ningún certificado.')),
      );
    }
  }

  Future<void> onSignDocument() async{
    Navigator.pop(context);
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Dialog(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                SizedBox(width: 16),
                Text("Firmando documento..."),
              ],
            ),
          ),
        );
      },
    );

    Map<int, Uint8List> document = await apiSign.getDocumentValidated(token: _tokenPassDocument!);
    Map<int, String> signedDocuments = await signDocument(document, certifiedFile!, _password!);
    if(signedDocuments.isNotEmpty){
      await apiSign.updateDocumentSigned(token:  _tokenPassDocument!,signedDocuments:  signedDocuments,idUser:  _cedulaController.text);
    }
    Navigator.pop(context);
    Navigator.push(context, MaterialPageRoute(builder: (context) => DowloadShareScreen(signedDocuments: signedDocuments)));
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: const CustomAppBar(title: "Firmado libre"),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(onPressed: onSubmitPDF, child: const Text("Cargar pdf")),
              const SizedBox(height: 16),
              _isDocumentSelected && _documentBytes != null ?
                  Expanded(
                      child: Column(
                        children: [
                          Text('$_documentName'),
                          const SizedBox(height: 16),
                          Expanded(
                            child: SfPdfViewer.memory(
                              _documentBytes!,
                              key: _pdfViewerKey,
                              controller: _pdfViewerController,
                            ),
                          )
                        ],
                      )):
                  const Text("No se ha podido seleciconar el documento"),
              TextField(
                controller: _cedulaController,
                decoration: const InputDecoration(labelText: 'Cédula'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                  onPressed: !_passCertified ? validatedDocument : null,
                  child: const Text("Validar documento y cedula")
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                  onPressed: _passCertified ? onSubmitCertified : null,
                  child: const Text("Cargar certificado")
              ),
            ],
          ),
        ),
      ),
    );
  }
}