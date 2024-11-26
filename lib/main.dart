import 'package:firmonec/config/config_api.dart';
import 'package:firmonec/config/config_api_sign.dart';
import 'package:firmonec/presentation/screens/login.dart';
import 'package:firmonec/presentation/screens/quipux/demo_sign.dart';
import 'package:firmonec/presentation/screens/quipux/documents_for_sign.dart';
import 'package:firmonec/presentation/screens/quipux/pre_configuration_certificates.dart';
import 'package:firmonec/presentation/screens/quipux/pre_configuration_id.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() {
  AppConfig(typeConfig: TypeConfig.development, typeApiFirma: TypeApiFirma.firmonec);
  ConfigApiSign();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  Future<Widget> _selectView() async {
    final prefs = await SharedPreferences.getInstance();
    if(prefs.getString("emailUser") == null && prefs.getString("passwordUser") == null){
      return const Login();
    }
    if(prefs.getString("idUser") == null){
      return const PreConfigurationId();
    }
    if(prefs.getStringList("certificates") == null){
      return const PreConfigurationCertificate();
    }
      return const DemoSign();

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Firmonec',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        home: FutureBuilder<Widget>(
            future: _selectView(),
            builder: (context, snapshot) {
              if(snapshot.connectionState == ConnectionState.waiting){
                return const Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }

              if(snapshot.hasError){
                return Scaffold(
                  body: Center(
                    child: Text("Error, ${snapshot.error}"),
                  ),
                );
              }
              return snapshot.data!;
            }
        ),
        routes: {
          "/login": (context) => const Login(),
          "/pre_configuration_id": (context) => const PreConfigurationId(),
          "/pre_configuration_certificate": (context) =>const PreConfigurationCertificate(),
          "/documents_for_sign": (context) => const DocumentsForSign(),
          "/demo_sign": (context) => const DemoSign(),
        },
    );
  }
}