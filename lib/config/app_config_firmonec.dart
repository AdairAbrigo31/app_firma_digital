class AppConfigFirmonec{
  static AppConfigFirmonec? _instance;

  static const String urlApiSign = "http://34.56.229.106:8081";
  static const String endpointApiSign = "servicio/documentos";
  static const String tokenApiSign = "7b800e8d6e7ca6bc82d1ce2675f0bcbb14afc77da51dee94d440f89570683e64";

  static const String urlApiSignLocal = "http://10.0.2.2:8081";
  static const String endpointApiSignLocal = "servicio/documentos";
  static const String tokenApiSignLocal = "4398df874a21f3633e067a8e3e1f9dcbc244271eb114549c66f374793a9a2d13";

  AppConfigFirmonec._internal();

  factory AppConfigFirmonec(){
    _instance ??= AppConfigFirmonec._internal();
    return _instance!;
  }

  static AppConfigFirmonec get instance {
    if (_instance == null) {
      throw StateError('AppConfig debe ser inicializado primero');
    }
    return _instance!;
  }

  String getUrlForSign(){
    return '$urlApiSign/$endpointApiSign';
  }

  String getTokenApiSign(){
    return tokenApiSign;
  }

  String getUrlForSignLocal(){
    return "$urlApiSignLocal/$endpointApiSignLocal";
  }

  String getTokenApiSignLocal(){
    return tokenApiSignLocal;
  }

}