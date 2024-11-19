import 'package:flutter/material.dart';

class TextInputEmailQuipux extends StatelessWidget {
  final Function(String) onTextChanged;
  final focusNode = FocusNode();
  final border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(30),
    borderSide: BorderSide.none,
  );
  final enabledBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(30),
    borderSide: BorderSide(
      color: Colors.grey[300]!,
      width: 1,
    ),
  );

  TextInputEmailQuipux({super.key, required this.onTextChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16), // Padding para control del ancho
      child: Container(
        constraints: const BoxConstraints(
          maxWidth: 400, // Ancho máximo del campo
        ),
        child: TextFormField(
          focusNode: focusNode,
          decoration: InputDecoration(
            hintText: "Usuario Quipux",
            hintStyle: TextStyle(
              color: Colors.grey[400], // Color más suave para el placeholder
            ),
            prefixIcon: const Icon(
              Icons.account_circle_outlined,
              color: Colors.grey, // Color del icono
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 16,
            ),
            filled: true,
            fillColor: Colors.grey[100], // Color de fondo suave
            border: border,
            enabledBorder: enabledBorder,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(
                color: Theme.of(context).primaryColor,
                width: 2,
              ),
            ),
          ),
          onChanged: onTextChanged,
          onTapOutside: (event) => focusNode.unfocus(),
          textAlign: TextAlign.center, // Centra el texto
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),

      ),
    );
  }
}