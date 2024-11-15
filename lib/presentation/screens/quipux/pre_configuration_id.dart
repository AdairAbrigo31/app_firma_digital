import 'package:flutter/material.dart';

class PreConfigurationId extends StatefulWidget {
  const PreConfigurationId({super.key});

  @override
  State<PreConfigurationId> createState() => _PreConfigurationIdState();
}

class _PreConfigurationIdState extends State<PreConfigurationId> {
  String userId = '';
  final _formKey = GlobalKey<FormState>();

  void _onTextChanged(String value) {
    setState(() {
      userId = value;
    });
  }

  void _onSubmit() {
    if (_formKey.currentState?.validate() ?? false) {
      // Aquí puedes navegar a la siguiente pantalla o realizar la acción necesaria
      Navigator.pushNamed(context, '/next-screen');  // Ajusta según tu navegación
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configuración'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 40),

                  // Ícono o imagen
                  Icon(
                    Icons.person_outline,
                    size: 80,
                    color: Theme.of(context).primaryColor,
                  ),

                  const SizedBox(height: 32),

                  // Título
                  Text(
                    "Identificación requerida",
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Descripción
                  Text(
                    "Por favor ingrese su número de cédula.\nEs necesario para habilitar la opción de firmado.",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.grey[600],
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Campo de texto con validación
                  Container(
                    constraints: const BoxConstraints(maxWidth: 400),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Número de cédula',
                        hintText: 'Ej: 1234567890',
                        prefixIcon: const Icon(Icons.credit_card),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        filled: true,
                        fillColor: Colors.grey[50],
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: _onTextChanged,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor ingrese su número de cédula';
                        }
                        if (value.length < 10) {
                          return 'La cédula debe tener al menos 10 dígitos';
                        }
                        return null;
                      },
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Botón de continuar
                  Container(
                    width: double.infinity,
                    constraints: const BoxConstraints(maxWidth: 400),
                    child: ElevatedButton(
                      onPressed: _onSubmit,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Continuar',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}