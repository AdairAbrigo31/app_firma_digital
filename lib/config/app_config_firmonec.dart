class AppConfig{
  static AppConfig? _instance;

  static const String urlApiSign = "https://34.56.229.106:8080/";
  static const String endpointApiSign = "servicio";

  static const String urlApiQuipux = "";
  static const String endpointApiQuipux = "";

  AppConfig._internal();

  factory AppConfig(){
    _instance ??= AppConfig._internal();
    return _instance!;
  }

  static AppConfig get instance {
    if (_instance == null) {
      throw StateError('AppConfig debe ser inicializado primero');
    }
    return _instance!;
  }

  String getUrlForSign(){
    return '$urlApiSign/$endpointApiSign';
  }

}