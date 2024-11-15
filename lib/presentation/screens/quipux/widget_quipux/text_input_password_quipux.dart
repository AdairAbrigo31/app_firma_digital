import 'package:flutter/material.dart';

class TextInputPasswordQuipux extends StatefulWidget {  // Cambiado a StatefulWidget para manejar visibilidad
  final Function(String) onTextChanged;

  const TextInputPasswordQuipux({super.key, required this.onTextChanged});

  @override
  State<TextInputPasswordQuipux> createState() => _TextInputPasswordQuipuxState();
}

class _TextInputPasswordQuipuxState extends State<TextInputPasswordQuipux> {
  final focusNode = FocusNode();
  bool _obscureText = true;  // Controla la visibilidad de la contraseña

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      child: Container(
        constraints: const BoxConstraints(
          maxWidth: 400,
        ),
        child: TextFormField(
          focusNode: focusNode,
          obscureText: _obscureText,  // Oculta el texto
          decoration: InputDecoration(
            hintText: "Contraseña",
            hintStyle: TextStyle(
              color: Colors.grey[400],
            ),
            prefixIcon: const Icon(
              Icons.lock_outline,  // Cambiado el icono a un candado
              color: Colors.grey,
            ),
            suffixIcon: IconButton(  // Botón para mostrar/ocultar contraseña
              icon: Icon(
                _obscureText ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                color: Colors.grey,
              ),
              onPressed: () {
                setState(() {
                  _obscureText = !_obscureText;
                });
              },
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 16,
            ),
            filled: true,
            fillColor: Colors.grey[100],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(
                color: Colors.grey[300]!,
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(
                color: Theme.of(context).primaryColor,
                width: 2,
              ),
            ),
          ),
          onChanged: widget.onTextChanged,
          onTapOutside: (event) => focusNode.unfocus(),
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          autocorrect: false,  // Desactiva la autocorrección
          enableSuggestions: false,  // Desactiva las sugerencias
          keyboardType: TextInputType.visiblePassword,  // Teclado específico para contraseñas
        ),
      ),
    );
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }
}