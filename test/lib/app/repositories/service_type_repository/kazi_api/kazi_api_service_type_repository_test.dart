// import 'package:flutter_test/flutter_test.dart';
// import 'package:kazi/app/core/errors/errors.dart';
// import 'package:kazi/app/core/l10n/generated/l10n.dart';
// import 'package:kazi/app/models/service_type.dart';
// import 'package:kazi/app/repositories/service_type_repository/kazi_api/kazi_api_service_type_repository.dart';
// import 'package:kazi/app/services/api_service/http/http_api_service.dart';
// import 'package:mockito/annotations.dart';
// import 'package:mockito/mockito.dart';

// import '../../../../../mocks/mocks.dart';
// import '../../../../../utils/test_helper.dart';
// import '../../../../../utils/test_matchers.dart';
// import 'firebase_service_type_repository_test.mocks.dart';

// @GenerateMocks([HttpApiService])
// void main() {
//   late MockHttpApiService apiService;
//   late KaziApiServiceTypeRepository repository;

//   setUpAll(() {
//     TestHelper.loadAppLocalizations();
//   });

//   setUp(() async {
//     apiService = MockHttpApiService();
//     repository = KaziApiServiceTypeRepository(apiService);
//   });

//   group('Add Service Type', () {
//     test('Should add service type', () async {
//       final response = await repository.add(serviceTypeMock);
//       expect(response, IsTheSameServiceType(serviceTypeMock));
//       expect(response.id, isNotEmpty);
//     });

//     test('Should throw ExternalError with errorToAddServiceType message', () {
//       database = MockFirebaseFirestore();
//       repository = FirebaseServiceTypeRepository(database);
//       when(database.collection(repository.path)).thenThrow(Exception());

//       expectLater(
//           repository.add(serviceTypeMock),
//           ErrorWithMessage<ExternalError>(
//               AppLocalizations.current.errorToAddServiceType));
//     });
//   });

//   group('Delete Service Type', () {
//     late String serviceTypeId;

//     setUp(() async {
//       final response = await firebaseHelper.add(serviceTypeMock.toMap(),
//           (snapshot) => serviceTypeMock.copyWith(id: snapshot.id));
//       serviceTypeId = response.id;
//     });

//     test('Should delete service type', () async {
//       expect(repository.delete(serviceTypeId), completion(null));

//       final response = await firebaseHelper.get(
//           serviceTypeId,
//           (snapshot, data) =>
//               ServiceType.fromJson(data).copyWith(id: snapshot.id));

//       expect(response, isNull);
//     });

//     test('Should throw ExternalError with message errorToDeleteServiceType',
//         () async {
//       database = MockFirebaseFirestore();
//       repository = FirebaseServiceTypeRepository(database);
//       when(database.collection(repository.path)).thenThrow(Exception());

//       expect(
//           repository.delete(serviceTypeId),
//           ErrorWithMessage<ExternalError>(
//               AppLocalizations.current.errorToDeleteServiceType));
//     });
//   });

//   group('Get Service Types', () {
//     const userNumberOfServiceTypes = 5;

//     setUp(() async {
//       for (var i = 0; i < userNumberOfServiceTypes; i++) {
//         await firebaseHelper.add(serviceTypeMock.toMap(),
//             (snapshot) => serviceTypeMock.copyWith(id: snapshot.id));
//       }

//       //Service type to another user
//       await firebaseHelper.add(
//           serviceTypeMock.copyWith(userId: 'aaaa9999').toMap(),
//           (snapshot) => serviceTypeMock.copyWith(id: snapshot.id));
//     });

//     test('Should get service types', () async {
//       final response = await repository.get(serviceTypeMock.userId);
//       expect(response, hasLength(userNumberOfServiceTypes));
//       expect(
//         response,
//         everyElement(predicate(
//             (e) => e is ServiceType && e.userId == serviceTypeMock.userId)),
//       );
//     });

//     test('Should throw ExternalError with message errorToGetServiceTypes',
//         () async {
//       database = MockFirebaseFirestore();
//       repository = FirebaseServiceTypeRepository(database);
//       when(database.collection(repository.path)).thenThrow(Exception());

//       expect(
//           repository.get(serviceTypeMock.userId),
//           ErrorWithMessage<ExternalError>(
//               AppLocalizations.current.errorToGetServiceTypes));
//     });
//   });

//   group('Update Service Type', () {
//     late String serviceTypeId;

//     setUp(() async {
//       final response = await firebaseHelper.add(serviceTypeMock.toMap(),
//           (snapshot) => serviceTypeMock.copyWith(id: snapshot.id));
//       serviceTypeId = response.id;
//     });

//     test('Should update service type', () async {
//       final toUpdate =
//           serviceTypeMock.copyWith(id: serviceTypeId, name: 'Update test');
//       await repository.update(toUpdate);

//       final response = await firebaseHelper.get(
//         toUpdate.id,
//         (snapshot, data) =>
//             ServiceType.fromJson(data).copyWith(id: snapshot.id),
//       );
//       expect(response, IsTheSameServiceType(toUpdate, checkEqualsId: true));
//     });

//     test('Should throw ExternalError with message errorToUpdateServiceType',
//         () async {
//       database = MockFirebaseFirestore();
//       repository = FirebaseServiceTypeRepository(database);
//       when(database.collection(repository.path)).thenThrow(Exception());

//       expect(
//           repository.update(serviceTypeMock),
//           ErrorWithMessage<ExternalError>(
//               AppLocalizations.current.errorToUpdateServiceType));
//     });
//   });
// }

void main() {}
