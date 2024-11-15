import 'package:firmonec/domain/entities/IResonseCargo.dart';

abstract class ApiQuipux {

  IResponseCargo getDocumentsByCargo();

  Future<void> updateDocumentEnElaboracionByCargo();

  Future<void> updateDocumentReasignadoByCargo();
}