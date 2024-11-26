import 'dart:io';

import 'package:firmonec/config/config_persistence_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ICertificate {
  Future<void> loadCertificate () async {
    final prefs = await SharedPreferences.getInstance();
    final savedCertificates = prefs.getStringList(ConfigPersistenceData.instance.getNameForPersistToIdUser()) ?? [];

    final validCertificates = <String>[];
    for (final path in savedCertificates) {
      if (await File(path).exists()) {
        validCertificates.add(path);
      }
    }
  }


}