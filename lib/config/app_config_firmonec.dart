abstract class IAppConfig {
  final String urlAPISign;
  final String urlAPIQuipux;

  IAppConfig({required this.urlAPISign, required this.urlAPIQuipux});
}

class AppConfigFirmonec extends IAppConfig {
  static AppConfigFirmonec? _instance;

  // URLs por defecto
  static const String _defaultUrlAPISign = 'http://localhost:8081/api';
  static const String _defaultUrlAPIQuipux = 'http://localhost:8082/api';

  // Constructor privado
  AppConfigFirmonec._({
    required String urlAPISign,
    required String urlAPIQuipux,
  }) : super(
    urlAPISign: urlAPISign,
    urlAPIQuipux: urlAPIQuipux,
  );

  // Fábrica para obtener la instancia singleton
  factory AppConfigFirmonec.instance({
    String? urlAPISign,
    String? urlAPIQuipux,
  }) {
    _instance ??= AppConfigFirmonec._(
      urlAPISign: urlAPISign ?? _defaultUrlAPISign,
      urlAPIQuipux: urlAPIQuipux ?? _defaultUrlAPIQuipux,
    );
    return _instance!;
  }


  String getUrlFirmonec() {
    return '$urlAPISign/firmonec';
  }

  String getUrlQuipux() {
    return '$urlAPIQuipux/quipux';
  }

}