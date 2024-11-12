import 'package:firmonec/presentation/screens/quipux/widget_quipux/app_bar_quipux.dart';
import 'package:flutter/material.dart';

class DocumentsForSign extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        appBar: AppBarQuipux(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Documentos pendientes")
            ],
          ),
        )
      )
    );
  }


}