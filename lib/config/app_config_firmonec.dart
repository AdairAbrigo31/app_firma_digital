class AppConfigFirmonec{
  static AppConfigFirmonec? _instance;

  static const String urlApiSign = "https://34.56.229.106:8081";
  static const String endpointApiSign = "servicio/documentos";

  static const String urlApiQuipux = "";
  static const String endpointApiQuipux = "";

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

}