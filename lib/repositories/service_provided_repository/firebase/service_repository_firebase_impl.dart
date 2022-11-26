import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_services/core/errors/app_error.dart';
import 'package:my_services/models/service_provided.dart';
import 'package:my_services/repositories/service_provided_repository/firebase/models/service_provided_firebase.dart';
import 'package:my_services/repositories/service_provided_repository/service_provided_repository.dart';
import 'package:my_services/shared/extensions/extensions.dart';

class ServiceProvidedRepositoryFirebaseImpl extends ServiceProvidedRepository {
  final FirebaseFirestore _firestore;
  static const _path = 'services';

  ServiceProvidedRepositoryFirebaseImpl(FirebaseFirestore firestore)
      : _firestore = firestore;

  @override
  Future<List<ServiceProvided>> add(ServiceProvided service,
      [int quantity = 1]) async {
    try {
      final batch = _firestore.batch();
      final data = ServiceProvidedFirebase.fromServiceProvided(service);
      final result = <ServiceProvided>[];

      for (var i = 0; i < quantity; i++) {
        final collection = _firestore.collection(_path).doc();
        batch.set(collection, data.toMap());
        result.add(data.copyWith(id: collection.id));
      }

      await batch.commit();
      return result;
    } catch (exception) {
      throw ExternalError('Erro ao efetuar a adição do serviço realizado',
          exception.toString());
    }
  }

  @override
  Future<void> delete(String id) async {
    try {
      await _firestore.collection(_path).doc(id).delete();
    } catch (exception) {
      throw ExternalError('Erro ao efetuar a deleção do serviço realizado',
          exception.toString());
    }
  }

  @override
  Future<void> update(ServiceProvided service) async {
    try {
      final data = ServiceProvidedFirebase.fromServiceProvided(service).toMap();
      await _firestore.collection(_path).doc(service.id).update(data);
    } catch (exception) {
      throw ExternalError('Erro ao efetuar a edição do serviço realizado',
          exception.toString());
    }
  }

  @override
  Future<List<ServiceProvided>> get(
    String userId, [
    DateTime? startDate,
    DateTime? endDate,
  ]) async {
    try {
      startDate ??= DateTime.now();
      var query = _firestore
          .collection(_path)
          .where('userId', isEqualTo: userId)
          .where('date', isGreaterThanOrEqualTo: startDate);

      if (endDate != null) {
        query = query.where('date', isLessThanOrEqualTo: endDate);
      }

      final finalQuery = await query.getCacheFirst();

      final result = finalQuery.docs.map((DocumentSnapshot snapshot) {
        final data = snapshot.data() as Map<String, dynamic>;
        return ServiceProvidedFirebase.fromMap(data).copyWith(id: snapshot.id);
      }).toList();

      return result;
    } catch (exception) {
      throw ExternalError(
          'Erro ao buscar serviços realizados', exception.toString());
    }
  }

  @override
  Future<int> count(String userId, [String? typeId]) async {
    try {
      final query =
          _firestore.collection(_path).where('userId', isEqualTo: userId);

      if (typeId != null) {
        query.where('typeId', isEqualTo: typeId);
      }

      final result = await query.count().get();
      return result.count;
    } catch (exception) {
      throw ExternalError(
          'Erro ao buscar quantidade de serviços', exception.toString());
    }
  }
}
