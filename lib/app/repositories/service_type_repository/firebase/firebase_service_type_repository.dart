import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:kazi/app/models/service_type.dart';
import 'package:kazi/app/services/crashlytics_service/crashlytics_service.dart';
import 'package:kazi/app/shared/errors/errors.dart';
import 'package:kazi/app/shared/extensions/extensions.dart';
import 'package:kazi/app/shared/l10n/generated/l10n.dart';
import 'package:kazi/app/shared/utils/log_utils.dart';

import '../service_type_repository.dart';

class FirebaseServiceTypeRepository extends ServiceTypeRepository {

  FirebaseServiceTypeRepository(
      FirebaseFirestore firestore, this._crashlyticsService,)
      : _firestore = firestore;
  final FirebaseFirestore _firestore;
  final CrashlyticsService _crashlyticsService;

  @visibleForTesting
  String get path => 'serviceTypes';

  @override
  Future<ServiceType> add(ServiceType serviceType) async {
    try {
      final data = serviceType.toMap();
      final document = await _firestore.collection(path).add(data);
      final result = serviceType.copyWith(id: document.id);
      return result;
    } catch (exception, trace) {
      Log.error(exception);
      _crashlyticsService.log(exception, trace);
      throw ExternalError(AppLocalizations.current.errorToAddServiceType,
          trace: exception.toString(),);
    }
  }

  @override
  Future<void> delete(String id) async {
    try {
      await _firestore.collection(path).doc(id).delete();
    } catch (exception, trace) {
      Log.error(exception);
      _crashlyticsService.log(exception, trace);
      throw ExternalError(AppLocalizations.current.errorToDeleteServiceType,
          trace: exception.toString(),);
    }
  }

  @override
  Future<List<ServiceType>> get(String userId) async {
    try {
      final query = await _firestore
          .collection(path)
          .where('userId', isEqualTo: userId)
          .getCacheFirst();

      final result = query.docs.map((DocumentSnapshot snapshot) {
        final data = snapshot.data() as Map<String, dynamic>;
        return ServiceType.fromMap(data).copyWith(id: snapshot.id);
      }).toList();

      return result;
    } catch (exception) {
      Log.error(exception);
      throw ExternalError(AppLocalizations.current.errorToGetServiceTypes,
          trace: exception.toString(),);
    }
  }

  @override
  Future<void> update(ServiceType serviceType) async {
    try {
      final data = serviceType.toMap();
      await _firestore.collection(path).doc(serviceType.id).update(data);
    } catch (exception) {
      Log.error(exception);
      throw ExternalError(AppLocalizations.current.errorToUpdateServiceType,
          trace: exception.toString(),);
    }
  }
}
