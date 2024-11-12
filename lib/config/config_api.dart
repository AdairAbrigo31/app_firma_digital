enum TypeConfig {
  development,
  production
}

enum TypeApiFirma {
  firmonec,
  espol
}

class AppConfig{
  final TypeConfig typeConfig;
  final TypeApiFirma typeApiFirma;
  static AppConfig? _instance;

  static const String urlFirmonecDevelopment = "http://10.0.2.2:8081";
  static const String urlServerDevelopment = "http://10.0.2.2:4201";
  static const String endpointFirmonecDevelopment = "servicio/documentos";
  static const String endpointServerDevelopment = "api/quipux/cargardocumento";

  static const String urlFirmonecProduction = "";
  static const String urlServerProduction = "";
  static const String endpointFirmonecProduction = "";
  static const String endpointServerProduction = "";

  static const String urlApiFirmaEspol = "";

  AppConfig._internal(this.typeConfig, this.typeApiFirma);

  factory AppConfig({required TypeConfig typeConfig, required TypeApiFirma typeApiFirma}){
    _instance ??= AppConfig._internal(typeConfig, typeApiFirma);
    return _instance!;
  }

  static AppConfig get instance {
    if (_instance == null) {
      throw StateError('AppConfig debe ser inicializado primero');
    }
    return _instance!;
  }

  String getUrlFirmonec (){
    if(typeConfig == TypeConfig.development && typeApiFirma == TypeApiFirma.firmonec){
      return '$urlFirmonecDevelopment/$endpointFirmonecDevelopment';
    }else{
      return '$urlFirmonecProduction/$endpointFirmonecProduction';
    }
  }

  String getUrlServer (){
    if(typeConfig == TypeConfig.development && typeApiFirma == TypeApiFirma.firmonec){
      return '$urlServerDevelopment/$endpointServerDevelopment';
    }else{
      return '$urlServerProduction/$endpointServerProduction';
    }
  }

}