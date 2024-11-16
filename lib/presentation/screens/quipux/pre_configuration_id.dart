import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreConfigurationId extends StatefulWidget {
  const PreConfigurationId({super.key});

  @override
  State<PreConfigurationId> createState() {
    return _PreConfigurationIdState();
  }

}

class _PreConfigurationIdState extends State<PreConfigurationId>{
  String userId = "";
  final _formKey = GlobalKey<FormState>();

  void _onTextChanged(String value){
    setState(() {
      userId = value;
    });
  }

  void _onSubmit() async {
    if(_formKey.currentState?.validate() ?? false){
      await saveUserId(userId);
      Navigator.pushNamed(context, "/documents_for_sign");
    }
  }

  Future<void> saveUserId(String userId) async {
    final prefers = await SharedPreferences.getInstance();
    await prefers.setString("userId", userId);
    
    if(!mounted){
      return;
    }
    Navigator.pushReplacementNamed(context, "/documents_for_sign");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    Icon(
                      Icons.person_2_outlined,
                      size: 80,
                      color: Theme.of(context).primaryColor,
                    ),
                    const SizedBox(height: 32),
                    Text(
                      "Identificación requerida",
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold
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

                    Container(
                      constraints: const BoxConstraints(maxWidth: 400),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        onChanged: (value) => _onTextChanged(value),
                        validator: (value) {
                          if(value == null || value.isEmpty){
                            return"Por favor ingrese su número de cedula";
                          }
                          if(value.length < 10){
                            return "La cedula debe tener al menos de 10 digitos";
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 32,),
                    Container(
                      width: double.infinity,
                      constraints: const BoxConstraints(maxWidth: 400),
                      child: ElevatedButton(
                        onPressed: () => _onSubmit(),
                        child: const Text(
                          "Continuar",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          ),
                      ),
                    )
                  ],
                ),
              ),
          )
          ),
      )
    );
  }
}