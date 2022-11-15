import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_services/core/errors/app_error.dart';
import 'package:my_services/models/service_type.dart';
import 'package:my_services/repositories/service_type_repository/service_type_repository.dart';

class ServiceTypeRepositoryFirebaseImpl extends ServiceTypeRepository {
  final FirebaseFirestore _firestore;
  static const _path = 'service_type';

  ServiceTypeRepositoryFirebaseImpl(FirebaseFirestore firestore)
      : _firestore = firestore;

  @override
  Future<ServiceType> add(ServiceType service) async {
    try {
      final data = service.toMap();
      final document = await _firestore.collection(_path).add(data);
      final result = service.copyWith(id: document.id);
      return result;
    } catch (exception) {
      throw ExternalError(
          'Erro ao efetuar a adição do tipo de serviço', exception.toString());
    }
  }

  @override
  Future<void> delete(String id) async {
    try {
      await _firestore.collection(_path).doc(id).delete();
    } catch (exception) {
      throw ExternalError(
          'Erro ao efetuar a deleção do tipo de serviço', exception.toString());
    }
  }

  @override
  Future<void> update(ServiceType service) async {
    try {
      final data = service.toMap();
      await _firestore.collection(_path).doc(service.id).update(data);
    } catch (exception) {
      throw ExternalError(
          'Erro ao efetuar a edição do tipo de serviço', exception.toString());
    }
  }

  @override
  Future<List<ServiceType>> get(String userId) async {
    try {
      final query = await _firestore
          .collection(_path)
          .where('userId', isEqualTo: userId)
          .get();

      final result = query.docs.map((DocumentSnapshot snapshot) {
        final data = snapshot.data() as Map<String, dynamic>;
        return ServiceType.fromMap(data).copyWith(id: snapshot.id);
      }).toList();

      return result;
    } catch (exception) {
      throw ExternalError(
          'Erro ao buscar serviços realizados', exception.toString());
    }
  }
}
