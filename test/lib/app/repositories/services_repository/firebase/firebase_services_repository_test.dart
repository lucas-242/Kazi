import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kazi/app/models/service.dart';
import 'package:kazi/app/repositories/services_repository/firebase/firebase_services_repository.dart';
import 'package:kazi/app/repositories/services_repository/firebase/models/firebase_service_model.dart';
import 'package:kazi/app/services/crashlytics_service/crashlytics_service.dart';
import 'package:kazi/app/shared/errors/errors.dart';
import 'package:kazi/app/shared/l10n/generated/l10n.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../../mocks/mocks.dart';
import '../../../../../utils/firebase_test_helper.dart';
import '../../../../../utils/test_helper.dart';
import '../../../../../utils/test_matchers.dart';
import 'firebase_services_repository_test.mocks.dart';

@GenerateMocks([FirebaseFirestore, CrashlyticsService])
void main() {
  late FirebaseFirestore database;
  late FirebaseServicesRepository repository;
  late FirebaseTestHelper firebaseHelper;
  late MockCrashlyticsService crashlyticsService;

  TestHelper.loadAppLocalizations();

  setUp(() async {
    database = FakeFirebaseFirestore();
    crashlyticsService = MockCrashlyticsService();
    repository = FirebaseServicesRepository(database, crashlyticsService);
    firebaseHelper = FirebaseTestHelper(database, repository.path);
  });

  group('Add Service', () {
    test('Should add X services', () async {
      const quantity = 3;

      final response = await repository.add(serviceMock, quantity);
      expect(response, everyElement(IsTheSameService(serviceMock)));

      final serviceCount = await firebaseHelper.count();
      expect(serviceCount, quantity);

      final servicesAdded = await firebaseHelper.getAll((snapshot, data) =>
          FirebaseServiceModel.fromMap(data).copyWith(id: snapshot.id),);
      expect(response, containsAll(servicesAdded));
    });

    test('Should throw ExternalError with errorToAddService message', () {
      database = MockFirebaseFirestore();
      repository = FirebaseServicesRepository(database, crashlyticsService);
      when(database.collection(repository.path)).thenThrow(Exception());

      expectLater(
          repository.add(serviceMock),
          ErrorWithMessage<ExternalError>(
              AppLocalizations.current.errorToAddService,),);
    });
  });

  group('Count Services', () {
    final totalServicesToUser = servicesMock.length + 1;
    const typeId = 'abcde';
    const totalServicesToUserWithTargetTypeId = 1;

    setUp(() async {
      for (var service in servicesMock) {
        //Service to logged user
        await firebaseHelper.add(
            service.toMap(), (snapshot) => service.copyWith(id: snapshot.id),);

        //Service to another user
        await firebaseHelper.add(service.copyWith(userId: 'aaaa9999').toMap(),
            (snapshot) => service.copyWith(id: snapshot.id),);
      }

      //Service to logged user with different typeId
      await firebaseHelper.add(serviceMock.copyWith(typeId: typeId).toMap(),
          (snapshot) => serviceMock.copyWith(id: snapshot.id),);
    });

    test('Should count all user services', () async {
      final response = await repository.count(serviceMock.userId);
      expect(response, totalServicesToUser);
    });

    test('Should count user services by type', () async {
      final response = await repository.count(serviceMock.userId, typeId);
      expect(response, totalServicesToUserWithTargetTypeId);
    });

    test('Should throw ExternalError with message errorToCountServices',
        () async {
      database = MockFirebaseFirestore();
      repository = FirebaseServicesRepository(database, crashlyticsService);
      when(database.collection(repository.path)).thenThrow(Exception());

      expect(
          repository.count(serviceMock.userId),
          ErrorWithMessage<ExternalError>(
              AppLocalizations.current.errorToCountServices,),);
    });
  });

  group('Delete Service', () {
    late String serviceId;

    setUp(() async {
      final response = await firebaseHelper.add(serviceMock.toMap(),
          (snapshot) => serviceMock.copyWith(id: snapshot.id),);
      serviceId = response.id;
    });

    test('Should delete service', () async {
      expect(repository.delete(serviceId), completion(null));

      final response = await firebaseHelper.get(
          serviceId,
          (snapshot, data) =>
              FirebaseServiceModel.fromMap(data).copyWith(id: snapshot.id),);

      expect(response, isNull);
    });

    test('Should throw ExternalError with message errorToDeleteService',
        () async {
      database = MockFirebaseFirestore();
      repository = FirebaseServicesRepository(database, crashlyticsService);
      when(database.collection(repository.path)).thenThrow(Exception());

      expect(
          repository.delete(serviceId),
          ErrorWithMessage<ExternalError>(
              AppLocalizations.current.errorToDeleteService,),);
    });
  });

  group('Get Services', () {
    final userNumberOfServices = servicesMock.length;

    setUp(() async {
      for (var service in servicesMock) {
        //Service to logged user
        await firebaseHelper.add(
            service.toMap(), (snapshot) => service.copyWith(id: snapshot.id),);

        //Service to another user
        await firebaseHelper.add(service.copyWith(userId: 'aaaa9999').toMap(),
            (snapshot) => service.copyWith(id: snapshot.id),);
      }
    });

    test('Should get all user services', () async {
      final response =
          await repository.get(serviceMock.userId, serviceMock.date);
      expect(response, hasLength(userNumberOfServices));
      expect(
        response,
        everyElement(
            predicate((e) => e is Service && e.userId == serviceMock.userId),),
      );
    });

    test('Should get user services between two dates', () async {
      final servicesRange = servicesMock.getRange(2, 4);
      final startDate = servicesRange.first.date;
      final endDate = servicesRange.last.date;

      final response =
          await repository.get(serviceMock.userId, startDate, endDate);

      expect(response, hasLength(servicesRange.length));
      expect(
        response,
        everyElement(
          predicate(
            (e) =>
                e is Service &&
                e.userId == serviceMock.userId &&
                (e.date.isAfter(startDate) ||
                    e.date.isAtSameMomentAs(startDate)) &&
                (e.date.isBefore(endDate) || e.date.isAtSameMomentAs(endDate)),
          ),
        ),
      );
    });

    test('Should throw ExternalError with message errorToGetServices',
        () async {
      database = MockFirebaseFirestore();
      repository = FirebaseServicesRepository(database, crashlyticsService);
      when(database.collection(repository.path)).thenThrow(Exception());

      expect(
          repository.get(serviceMock.userId, serviceMock.date),
          ErrorWithMessage<ExternalError>(
              AppLocalizations.current.errorToGetServices,),);
    });
  });

  group('Update Service Type', () {
    late String serviceId;

    setUp(() async {
      final response = await firebaseHelper.add(serviceMock.toMap(),
          (snapshot) => serviceMock.copyWith(id: snapshot.id),);
      serviceId = response.id;
    });

    test('Should update service type', () async {
      final toUpdate = serviceMock.copyWith(id: serviceId, value: 9999);
      await repository.update(toUpdate);

      final response = await firebaseHelper.get(
        toUpdate.id,
        (snapshot, data) =>
            FirebaseServiceModel.fromMap(data).copyWith(id: snapshot.id),
      );
      expect(response, IsTheSameService(toUpdate, checkEqualsId: true));
    });

    test('Should throw ExternalError with message errorToUpdateService',
        () async {
      database = MockFirebaseFirestore();
      repository = FirebaseServicesRepository(database, crashlyticsService);
      when(database.collection(repository.path)).thenThrow(Exception());

      expect(
          repository.update(serviceMock),
          ErrorWithMessage<ExternalError>(
              AppLocalizations.current.errorToUpdateService,),);
    });
  });
}
