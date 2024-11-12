import 'package:firmonec/presentation/screens/signed_free.dart';
import 'package:firmonec/presentation/widgets_app/login_button.dart';
import 'package:flutter/material.dart';

class Login extends StatelessWidget{
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: "Firmonec",
      home: Scaffold(
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
                  LoginButton(
                    textButton: "Iniciar sesión QUipux",
                    onPressed: () => {print("Inicio sesión con su cuenta QUipux")}
                  ),
                  Builder(builder: (context) =>
                    LoginButton(
                      textButton: "Iniciar sesión sin registro",
                      onPressed: () => {Navigator.push(context, MaterialPageRoute(builder: (context) => SignedFree()))}
                    )
                  )
                ],
              ),
            )
        )
      ),
    );
  }

}