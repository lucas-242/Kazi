import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_services/core/errors/app_error.dart';
import 'package:my_services/models/service_provided.dart';
import 'package:my_services/repositories/service_provided_repository/firebase/models/service_provided_firebase.dart';
import 'package:my_services/repositories/service_provided_repository/service_provided_repository.dart';

class ServiceProvidedRepositoryFirebaseImpl extends ServiceProvidedRepository {
  final FirebaseFirestore _firestore;
  static const _path = 'service_provided';

  ServiceProvidedRepositoryFirebaseImpl(FirebaseFirestore firestore)
      : _firestore = firestore;

  @override
  Future<ServiceProvided> add(ServiceProvided service) async {
    try {
      final data = ServiceProvidedFirebase.fromServiceProvided(service).toMap();
      final document = await _firestore.collection(_path).add(data);
      final result = service.copyWith(id: document.id);
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
  Future<List<ServiceProvided>> get(String userId, {DateTime? dateTime}) async {
    try {
      dateTime ??= DateTime.now();
      final query = await _firestore
          .collection(_path)
          .where('user', isEqualTo: userId)
          .where('date', isGreaterThan: dateTime)
          .get();

      final result = query.docs.map((DocumentSnapshot snapshot) {
        final data = snapshot.data() as Map<String, dynamic>;
        return ServiceProvidedFirebase.fromMap(data).copyWith(id: snapshot.id);
      }).toList();

      return result;
    } catch (exception) {
      throw ExternalError(
          'Erro ao buscar serviços realizados', exception.toString());
    }
  }
}
