import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:my_services/repositories/services_repository/firebase/firebase_services_repository.dart';
import 'package:my_services/repositories/services_repository/firebase/models/firebase_service_model.dart';
import 'package:my_services/shared/errors/errors.dart';
import 'package:my_services/shared/l10n/generated/l10n.dart';

import '../../../mocks/mocks.dart';
import '../../../utils/firebase_test_helper.dart';
import '../../../utils/test_helper.dart';
import '../../../utils/test_matchers.dart';
import 'firebase_services_repository_test.mocks.dart';

@GenerateMocks([FirebaseFirestore])
void main() {
  late FirebaseFirestore database;
  late FirebaseServicesRepository repository;
  late FirebaseTestHelper firebaseHelper;

  TestHelper.loadAppLocalizations();

  setUp(() async {
    database = FakeFirebaseFirestore();
    repository = FirebaseServicesRepository(database);
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
          FirebaseServiceModel.fromMap(data).copyWith(id: snapshot.id));
      expect(response, containsAll(servicesAdded));
    });

    test('Should throw ExternalError with errorToAddService message', () {
      database = MockFirebaseFirestore();
      repository = FirebaseServicesRepository(database);
      when(database.collection(repository.path)).thenThrow(Exception());

      expectLater(
          repository.add(serviceMock),
          ErrorWithMessage<ExternalError>(
              AppLocalizations.current.errorToAddService));
    });
  });
}
