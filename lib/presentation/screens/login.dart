import 'package:firmonec/presentation/screens/quipux/pre_configuration_id.dart';
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

  String idUser = "";
  String passwordUser = "";
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                      "Esta aplicación se sincronizará con su cuenta de Quipux"),
                  TextInputEmailQuipux(onTextChanged: (value) =>
                  {
                    setState(() {
                      idUser = value;
                    })
                  }),
                  TextInputPasswordQuipux(onTextChanged: (value) => {
                    setState(() {
                      passwordUser = value;
                    })
                  }),
                  LoginButton(
                      textButton: "Iniciar sesión QUipux",
                      onPressed: () => {
                        Navigator.pushNamed(context, "/pre_configuration_id")
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
              ),
            )
        )
    );
  }
}