import 'package:flutter/material.dart';

class CedulaInput extends StatelessWidget {
  final TextEditingController controller;

  const CedulaInput({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: const InputDecoration(labelText: 'Cédula'),
    );
  }
}