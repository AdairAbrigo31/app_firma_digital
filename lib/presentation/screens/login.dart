import 'package:firmonec/config/config_persistence_data.dart';
import 'package:firmonec/domain/repositories/i_config_persistence_data.dart';
import 'package:firmonec/presentation/screens/quipux/widget_quipux/text_input_email_quipux.dart';
import 'package:firmonec/presentation/screens/quipux/widget_quipux/text_input_password_quipux.dart';
import 'package:firmonec/presentation/screens/without_quipux/signed_free.dart';
import 'package:firmonec/presentation/widgets_app/login_button.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget{
  const Login({super.key});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login>{
  final IConfigPersistenceData configPersistenceData = ConfigPersistenceData.instance;
  String emailUser = "";
  String passwordUser = "";

  void _onEmailChanged(String value){
    setState(() {
      emailUser = value;
    });
  }
  
  void _onPasswordChanged(String value){
    setState(() {
      passwordUser = value;
    });
  }

  Future<bool> _validateCredentials() async {
    //Logica de Auth (Interfaz en domain e implementación en data)
    return true;
  }

  bool validateInputs() {
    if(emailUser.trim().isEmpty){
      return false;
    }
    if(passwordUser == ""){
      return false;
    }
    return true;
  }
  
  void _onSubmit() async {
    if(!validateInputs()){
      return;
    }
    if(await _validateCredentials()){
      await _saveCredentials(emailUser: emailUser, passwordUser: passwordUser);
      if(!mounted){
        return;
      }
      Navigator.pushNamed(context, "/pre_configuration_id");
    }
  }
  
  Future<void> _saveCredentials({required String emailUser, required String passwordUser}) async {
    await configPersistenceData.setEmailInPersistence(emailUser);
    await configPersistenceData.setPasswordInPersistence(passwordUser);
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Inicio de sesión"),
          centerTitle: true,
        ),
        body: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 1),
              child: Form(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                          "Esta aplicación se sincronizará con su cuenta de Quipux"),
                      TextInputEmailQuipux(
                          onTextChanged: (value) {
                            _onEmailChanged(value);
                          },
                      ),
                      TextInputPasswordQuipux(onTextChanged: (value) => _onPasswordChanged(value)),
                      LoginButton(
                          textButton: "Iniciar sesión QUipux",
                          onPressed: () {
                            _onSubmit();
                          }
                      ),
                      Builder(builder: (context) =>
                          LoginButton(
                              textButton: "Iniciar sesión sin registro",
                              onPressed: () => {
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => SignedFree()))
                              }
                          )
                      )
                    ],
                  )
              )
            )
        )
    );
  }
}