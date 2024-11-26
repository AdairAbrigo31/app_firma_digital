import 'package:firmonec/domain/repositories/i_config_persistence_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfigPersistenceData implements IConfigPersistenceData{
  static ConfigPersistenceData? _instance;

  static const String _nameForPersistToIdUser = "idUser";
  static const String _nameForPersistToCertificates = "certificates";
  static const String _nameForPersistToEmail = "email";
  static const String _nameForPersistToPassword = "password";

  ConfigPersistenceData._internal();

  factory ConfigPersistenceData() {
    _instance ??= ConfigPersistenceData._internal();
    return _instance!;
  }

  static ConfigPersistenceData get instance{
    if(_instance == null) {
      throw StateError('ConfigPeristenceData de datos debe ser inicializada primero');
    }
    return _instance!;
  }

  @override
  Future<String?> getIdUserInPersistence() async {
    final prefs = await SharedPreferences.getInstance();
    String? nameForPersistToIdUser = prefs.getString(_nameForPersistToIdUser);
    return nameForPersistToIdUser;
  }

  @override
  Future<List<String>?> getCertificatesInPersistence() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? nameForPersistToCertificates = prefs.getStringList(_nameForPersistToCertificates);
    return nameForPersistToCertificates;
  }

  @override
  Future<String?> getEmailInPersistence() async {
    final prefs = await SharedPreferences.getInstance();
    String? nameForPersistToEmail = prefs.getString(_nameForPersistToEmail);
    return nameForPersistToEmail;
  }

  @override
  Future<String?> getPasswordInPersistence()  async {
    final prefs = await SharedPreferences.getInstance();
    String? nameForPersistPassword = prefs.getString(_nameForPersistToPassword);
    return nameForPersistPassword;
  }

  @override
  Future<void> setIdUserInPersistence(String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_nameForPersistToIdUser, value);
  }

  @override
  Future<void> setCertificates(List<String> value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_nameForPersistToCertificates, value);
  }

  @override
  Future<void> setEmailInPersistence(String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_nameForPersistToEmail, value);
  }

  @override
  Future<void> setPasswordInPersistence(String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_nameForPersistToPassword, value);
  }
}