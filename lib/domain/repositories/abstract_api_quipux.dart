import '../entities/IResponseEnElaboracion.dart';
import '../entities/IResponseEnviados.dart';
import '../entities/IResponseReasignados.dart';
import '../entities/IUser.dart';

abstract class AbstractApiQuipux {
  Future<IResponseEnElaboracion> getEnElaboracion();

  Future<IResponseReasignados> getReasignados();

  Future<IResponseEnviados> getEnviados();

  Future<void> postToQuipux();

  Future<IUser> doLogin({required String name, required String password});

  Future<void> doLogout();
}