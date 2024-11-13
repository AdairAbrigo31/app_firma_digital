import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firmonec/data/providers/document_provider.dart';
import 'package:firmonec/presentation/screens/quipux/documents_for_sign.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DocumentProvider()),
        // Aquí puedes agregar más providers si los necesitas
      ],
      child: MaterialApp(
        title: 'Firmonec',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
          // Puedes personalizar más el tema aquí
        ),
        home: const DocumentsForSign(),
      ),
    );
  }
}