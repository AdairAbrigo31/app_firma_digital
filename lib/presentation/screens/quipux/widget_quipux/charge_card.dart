import 'package:flutter/material.dart';

class ChargeCard extends StatelessWidget {
  const ChargeCard({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Cargando documentos...'),
          ],
        )
    );
  }
}