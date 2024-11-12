import 'package:firmonec/domain/entities/IResponseDocument.dart';
import '../entities/IResponseEnviados.dart';
import '../entities/IUser.dart';

abstract class AbstractApiQuipux {
  Future<IResponseDocument> getEnElaboracion();

  Future<IResponseDocument> getReasignados();

  Future<IResponseEnviados> getEnviados();

  Future<void> postToQuipux();

  Future<IUser> doLogin({required String name, required String password});

  Future<void> doLogout();
}