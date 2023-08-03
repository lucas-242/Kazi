import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:kazi/app/models/service_type.dart';
import 'package:kazi/app/repositories/service_type_repository/firebase/models/firebase_service_type.dart';
import 'package:kazi/app/core/errors/errors.dart';
import 'package:kazi/app/core/extensions/extensions.dart';
import 'package:kazi/app/core/l10n/generated/l10n.dart';

import '../service_type_repository.dart';

final class FirebaseServiceTypeRepository implements ServiceTypeRepository {
  FirebaseServiceTypeRepository(FirebaseFirestore firestore)
      : _firestore = firestore;
  final FirebaseFirestore _firestore;

  @visibleForTesting
  String get path => 'serviceTypes';

  @override
  Future<ServiceType> add(ServiceType serviceType) async {
    try {
      final data =
          FirebaseServiceTypeModel.fromServiceType(serviceType).toMap();
      final document = await _firestore.collection(path).add(data);
      final result = serviceType.copyWith(id: document.id);
      return result;
    } catch (exception) {
      throw ExternalError(AppLocalizations.current.errorToAddServiceType,
          trace: exception.toString());
    }
  }

  @override
  Future<void> delete(String id) async {
    try {
      await _firestore.collection(path).doc(id).delete();
    } catch (exception) {
      throw ExternalError(AppLocalizations.current.errorToDeleteServiceType,
          trace: exception.toString());
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
        return FirebaseServiceTypeModel.fromMap(data).copyWith(id: snapshot.id);
      }).toList();

      return result;
    } catch (exception) {
      throw ExternalError(AppLocalizations.current.errorToGetServiceTypes,
          trace: exception.toString());
    }
  }

  @override
  Future<void> update(ServiceType serviceType) async {
    try {
      final data =
          FirebaseServiceTypeModel.fromServiceType(serviceType).toMap();
      await _firestore.collection(path).doc(serviceType.id).update(data);
    } catch (exception) {
      throw ExternalError(AppLocalizations.current.errorToUpdateServiceType,
          trace: exception.toString());
    }
  }
}
