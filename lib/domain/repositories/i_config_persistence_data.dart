abstract class IConfigPersistenceData {
  Future<String?> getIdUserInPersistence();

  Future<List<String>?> getCertificatesInPersistence();

  Future<String?> getEmailInPersistence();

  Future<String?> getPasswordInPersistence();

  Future<void> setIdUserInPersistence(String value);

  //Pensado en guardar las rutas de los archivos
  Future<void> setCertificates(List<String> value);

  Future<void> setEmailInPersistence(String value);

  Future<void> setPasswordInPersistence(String value);
}