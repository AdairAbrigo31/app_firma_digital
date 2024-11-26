class ConfigPersistenceData {
  static ConfigPersistenceData? _instance;

  static const String _nameForPersistToIdUser = "idUser";
  static const String _nameForPersistToCertificates = "certificates";

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
    return _nameForPersistToIdUser;
  }

  String getNameForPersistToCertificates() {
    return _nameForPersistToCertificates;
  }
}