import 'package:firmonec/config/config_api.dart';
import 'package:firmonec/data/repositories/api_quipux_espol.dart';
import 'package:firmonec/data/repositories/api_sign_firmonec.dart';
import 'package:firmonec/domain/repositories/api_quipux.dart';
import 'package:firmonec/domain/repositories/api_sign.dart';
import 'package:firmonec/presentation/screens/login.dart';
import 'package:firmonec/presentation/screens/quipux/documents_for_sign.dart';
import 'package:firmonec/presentation/screens/quipux/pre_configuration_id.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firmonec/data/providers/document_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  AppConfig(typeConfig: TypeConfig.development, typeApiFirma: TypeApiFirma.firmonec);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final ApiQuipux apiQuipux = new ApiQuipuxEspol();
  final ApiSign apiSign = new ApiSignFirmonec();
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DocumentProvider()),
        // Aquí puedes agregar más providers si los necesitas
      ],
      child: MaterialApp(
        title: 'Firmonec',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        home: FutureBuilder<bool>(
            future: SharedPreferences.getInstance().then(
                (prefers) => prefers.getString("userId") != null
            ),
            builder: (context, snapshot){
              if(snapshot.connectionState == ConnectionState.waiting){
                return const CircularProgressIndicator();
              }
              return snapshot.data == true ? const DocumentsForSign() : const Login();
            }
        ),
        routes: {
          "/pre_configuration_id": (context) => PreConfigurationId(),
          "/documents_for_sign": (context) => DocumentsForSign()
        },
      ),
    );
  }
}