import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kazi/app/models/service.dart';
import 'package:kazi/app/services/crashlytics_service/crashlytics_service.dart';
import 'package:kazi/app/shared/errors/errors.dart';
import 'package:kazi/app/shared/extensions/extensions.dart';
import 'package:kazi/app/shared/l10n/generated/l10n.dart';
import 'package:kazi/app/shared/utils/log_utils.dart';

import '../services_repository.dart';
import 'models/firebase_service_model.dart';

class FirebaseServicesRepository extends ServicesRepository {

  FirebaseServicesRepository(
      FirebaseFirestore firestore, this.crashlyticsService,)
      : _firestore = firestore;
  final FirebaseFirestore _firestore;
  final CrashlyticsService crashlyticsService;
  String get path => 'services';

  @override
  Future<List<Service>> add(Service service, [int quantity = 1]) async {
    try {
      final batch = _firestore.batch();
      final data = FirebaseServiceModel.fromService(service);
      final result = <Service>[];

      for (var i = 0; i < quantity; i++) {
        final collection = _firestore.collection(path).doc();
        batch.set(collection, data.toMap());
        result.add(data.copyWith(id: collection.id));
      }

      await batch.commit();
      return result;
    } catch (exception, trace) {
      Log.error(exception);
      crashlyticsService.log(exception, trace);
      throw ExternalError(
        AppLocalizations.current.errorToAddService,
        trace: exception.toString(),
      );
    }
  }

  @override
  Future<void> delete(String id) async {
    try {
      await _firestore.collection(path).doc(id).delete();
    } catch (exception, trace) {
      Log.error(exception);
      crashlyticsService.log(exception, trace);
      throw ExternalError(
        AppLocalizations.current.errorToDeleteService,
        trace: exception.toString(),
      );
    }
  }

  @override
  Future<void> update(Service service) async {
    try {
      final data = FirebaseServiceModel.fromService(service).toMap();
      await _firestore.collection(path).doc(service.id).update(data);
    } catch (exception, trace) {
      Log.error(exception);
      crashlyticsService.log(exception, trace);
      throw ExternalError(
        AppLocalizations.current.errorToUpdateService,
        trace: exception.toString(),
      );
    }
  }

  @override
  Future<List<Service>> get(String userId, DateTime startDate,
      [DateTime? endDate,]) async {
    try {
      var query = _firestore
          .collection(path)
          .where('userId', isEqualTo: userId)
          .where('date', isGreaterThanOrEqualTo: startDate);

      if (endDate != null) {
        query = query.where('date', isLessThanOrEqualTo: endDate);
      }

      final finalQuery = await query.getCacheFirst();

      final result = finalQuery.docs.map((DocumentSnapshot snapshot) {
        final data = snapshot.data() as Map<String, dynamic>;
        return FirebaseServiceModel.fromMap(data).copyWith(id: snapshot.id);
      }).toList();

      return result;
    } catch (exception, trace) {
      Log.error(exception);
      crashlyticsService.log(exception, trace);
      throw ExternalError(
        AppLocalizations.current.errorToGetServices,
        trace: exception.toString(),
      );
    }
  }

  @override
  Future<int> count(String userId, [String? typeId]) async {
    try {
      var query =
          _firestore.collection(path).where('userId', isEqualTo: userId);

      if (typeId != null) {
        query = query.where('typeId', isEqualTo: typeId);
      }

      final result = await query.count().get();
      return result.count ?? 0;
    } catch (exception, trace) {
      Log.error(exception);
      crashlyticsService.log(exception, trace);
      throw ExternalError(
        AppLocalizations.current.errorToCountServices,
        trace: exception.toString(),
      );
    }
  }
}
