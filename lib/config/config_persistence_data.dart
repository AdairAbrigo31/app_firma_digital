class ConfigPersistenceData {
  static ConfigPersistenceData? _instance;

  static const String nameForPersistToIdUser = "idUser";
  static const String nameForPersistToCertificates = "certificates";

  ConfigPersistenceData._internal();

  factory ConfigPersistenceData() {
    _instance ?? ConfigPersistenceData._internal();
    return _instance!;
  }

  static ConfigPersistenceData get instance{
    if(_instance == null) {
      throw StateError('ConfigPeristenceData de datos debe ser inicializada primero');
    }
    return _instance!;
  }

  String getNameForPersistToIdUser() {
    return nameForPersistToIdUser;
  }

  String getnameForPersistToCertificates() {
    return nameForPersistToCertificates;
  }
}