import 'package:firmonec/domain/entities/IResponseEnElaboracion.dart';
import 'package:firmonec/domain/entities/IResponseEnviados.dart';
import 'package:firmonec/domain/entities/IResponseReasignados.dart';
import 'package:firmonec/domain/entities/IUser.dart';
import 'package:firmonec/domain/repositories/abstract_api_quipux.dart';

class ApiQuipux extends AbstractApiQuipux{
  @override
  Future<IResponseEnElaboracion> getEnElaboracion() {
    // TODO: implement getEnElaboracion
    throw UnimplementedError();
  }

  @override
  Future<IResponseEnviados> getEnviados() {
    // TODO: implement getEnviados
    throw UnimplementedError();
  }

  @override
  Future<void> postToQuipux() {
    // TODO: implement postToQuipux
    throw UnimplementedError();
  }

  @override
  Future<IResponseReasignados> getReasignados() {
    // TODO: implement getReasignados
    throw UnimplementedError();
  }

  @override
  Future<IUser> doLogin({required String name, required String password}) {
    // TODO: implement doLogin
    throw UnimplementedError();
  }

  @override
  Future<void> doLogout() {
    // TODO: implement doLogout
    throw UnimplementedError();
  }

}