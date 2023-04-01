import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:my_services/app/models/enums.dart';
import 'package:my_services/app/models/service.dart';
import 'package:my_services/app/repositories/service_type_repository/service_type_repository.dart';
import 'package:my_services/app/repositories/services_repository/firebase/models/firebase_service_model.dart';
import 'package:my_services/app/repositories/services_repository/services_repository.dart';
import 'package:my_services/app/services/auth_service/auth_service.dart';
import 'package:my_services/app/services/auth_service/firebase/errors/firebase_sign_in_error.dart';
import 'package:my_services/app/shared/errors/errors.dart';
import 'package:my_services/app/shared/l10n/generated/l10n.dart';
import 'package:my_services/app/shared/utils/base_state.dart';
import 'package:my_services/app/views/home/home.dart';

import '../../../../mocks/mocks.dart';
import '../../../../utils/test_helper.dart';
import 'home_cubit_test.mocks.dart';

@GenerateMocks([ServiceTypeRepository, ServicesRepository, AuthService])
void main() {
  late MockServiceTypeRepository serviceTypeRepository;
  late MockServicesRepository servicesRepository;
  late MockAuthService authService;
  late HomeCubit cubit;

  TestHelper.loadAppLocalizations();

  setUp(() {
    serviceTypeRepository = MockServiceTypeRepository();
    servicesRepository = MockServicesRepository();
    authService = MockAuthService();

    when(authService.user).thenReturn(userMock);

    when(serviceTypeRepository.get(any))
        .thenAnswer((_) async => serviceTypesWithIdsMock);

    when(servicesRepository.get(any, any, any))
        .thenAnswer((_) async => servicesWithTypeIdMock);

    cubit = HomeCubit(servicesRepository, serviceTypeRepository, authService);
  });

  group('Call onInit function', () {
    blocTest(
      'emits HomeState with loaded services and status success when call onInit',
      build: () => cubit,
      act: (cubit) => cubit.onInit(),
      expect: () => [
        HomeState(
          status: BaseStateStatus.success,
          services: servicesWithTypesMock,
        )
      ],
    );

    blocTest(
      'emits HomeState with empty services and status noData when call onInit',
      setUp: () {
        when(servicesRepository.get(any, any, any)).thenAnswer((_) async => []);
      },
      build: () => cubit,
      act: (cubit) => cubit.onInit(),
      expect: () => [
        HomeState(
          status: BaseStateStatus.noData,
        )
      ],
    );

    blocTest(
      'emits HomeState with status error and callbackMessage = errorToGetServices when call onInit',
      build: () => cubit,
      seed: () => HomeState(status: BaseStateStatus.noData),
      setUp: () {
        when(servicesRepository.get(any, any, any)).thenThrow(
            ExternalError(AppLocalizations.current.errorToGetServices));
      },
      act: (cubit) => cubit.onInit(),
      expect: () => [
        HomeState(
          callbackMessage: AppLocalizations.current.errorToGetServices,
          status: BaseStateStatus.error,
        )
      ],
    );

    blocTest(
      'emits HomeState with status error and callbackMessage = errorToGetServiceTypes when call onInit',
      build: () => cubit,
      seed: () => HomeState(status: BaseStateStatus.noData),
      setUp: () {
        when(serviceTypeRepository.get(any)).thenThrow(
            ExternalError(AppLocalizations.current.errorToGetServiceTypes));
      },
      act: (cubit) => cubit.onInit(),
      expect: () => [
        HomeState(
          callbackMessage: AppLocalizations.current.errorToGetServiceTypes,
          status: BaseStateStatus.error,
        )
      ],
    );

    blocTest(
      'emits HomeState with status error and callbackMessage = unknowError when call onInit',
      build: () => cubit,
      setUp: () {
        when(serviceTypeRepository.get(any)).thenThrow(Exception());
      },
      act: (cubit) => cubit.onInit(),
      expect: () => [
        HomeState(
          callbackMessage: AppLocalizations.current.unknowError,
          status: BaseStateStatus.error,
        )
      ],
    );
  });

  group('Call delete Service Type', () {
    late FirebaseServiceModel serviceToDelete;
    late List<Service> serviceList;

    setUp(() {
      serviceToDelete = serviceMock.copyWith(id: '123456', typeId: '1');
      serviceList = List.from(servicesWithTypeIdMock)..add(serviceToDelete);
    });

    blocTest(
      'emits HomeState with loaded services and status success when call deleteService',
      build: () => cubit,
      seed: () => HomeState(
        services: serviceList,
        status: BaseStateStatus.success,
      ),
      act: (cubit) => [cubit.deleteService(serviceToDelete)],
      expect: () => [
        HomeState(
          services: serviceList,
          status: BaseStateStatus.loading,
        ),
        HomeState(
          services: servicesWithTypeIdMock,
          status: BaseStateStatus.success,
        )
      ],
    );
  });

  group('Call onRefresh function', () {
    blocTest(
      'emits HomeState with loaded services and status success when call onRefresh',
      build: () => cubit,
      act: (cubit) => cubit.onRefresh(),
      expect: () => [
        HomeState(status: BaseStateStatus.loading),
        HomeState(
          status: BaseStateStatus.success,
          services: servicesWithTypesMock,
        )
      ],
    );
  });

  group('Call onChangeServices', () {
    blocTest(
      'emits HomeState with new services and status success when call onChangeServices',
      build: () => cubit,
      act: (cubit) => [cubit.onChangeServices()],
      expect: () => [
        HomeState(status: BaseStateStatus.loading),
        HomeState(
          services: servicesWithTypesMock,
          status: BaseStateStatus.success,
        )
      ],
    );

    blocTest(
      'emits HomeState with new services and status success when call onChangeServices',
      build: () => cubit,
      act: (cubit) => [cubit.onChangeServices()],
      expect: () => [
        HomeState(status: BaseStateStatus.loading),
        HomeState(
          services: servicesWithTypesMock,
          status: BaseStateStatus.success,
        )
      ],
    );

    blocTest(
      'emits HomeState with status error and callbackMessage = errorToGetServices when call onChangeServices',
      build: () => cubit,
      setUp: () {
        when(servicesRepository.get(any, any, any)).thenThrow(
            ClientError(AppLocalizations.current.errorToGetServices));
      },
      act: (cubit) => cubit.onChangeServices(),
      expect: () => [
        HomeState(status: BaseStateStatus.loading),
        HomeState(
          callbackMessage: AppLocalizations.current.errorToGetServices,
          status: BaseStateStatus.error,
        )
      ],
    );
  });

  group('Call onChangeOrderBy', () {
    blocTest(
      'emits HomeState with services ordered dateDesc and status success when call onChangeOrderBy',
      build: () => cubit,
      act: (cubit) => [cubit.onChangeOrderBy(OrderBy.dateDesc)],
      seed: () => HomeState(
        services: servicesWithTypesMock,
        status: BaseStateStatus.success,
      ),
      expect: () => [
        HomeState(
          services: servicesWithTypesMock,
          status: BaseStateStatus.success,
          selectedOrderBy: OrderBy.dateDesc,
        )
      ],
    );
  });

  group('State properties', () {
    test('totalValue should be 210', () {
      final state = HomeState(
        services: servicesWithTypesMock,
        status: BaseStateStatus.success,
        selectedOrderBy: OrderBy.dateDesc,
      );

      expect(state.totalValue, 210);
    });

    test('totalWithDiscount should be 105', () {
      final state = HomeState(
        services: servicesWithTypesMock,
        status: BaseStateStatus.success,
        selectedOrderBy: OrderBy.dateDesc,
      );

      expect(state.totalWithDiscount, 105);
    });

    test('totalDiscounted should be 105', () {
      final state = HomeState(
        services: servicesWithTypesMock,
        status: BaseStateStatus.success,
        selectedOrderBy: OrderBy.dateDesc,
      );

      expect(state.totalDiscounted, 105);
    });
  });

  group('Sign out', () {
    blocTest(
      'emits HomeState with status loading when call signOut',
      build: () => cubit,
      act: (cubit) => [cubit.signOut()],
      expect: () => [
        HomeState(
          status: BaseStateStatus.loading,
        )
      ],
    );

    blocTest(
      'emits HomeState with status error and methodNotAllowed message when call signOut',
      build: () => cubit,
      setUp: () => when(authService.signOut())
          .thenThrow(FirebaseSignInError.fromCode('operation-not-allowed')),
      act: (cubit) => [cubit.signOut()],
      expect: () => [
        HomeState(status: BaseStateStatus.loading),
        HomeState(
            status: BaseStateStatus.error,
            callbackMessage: AppLocalizations.current.methodNotAllowed)
      ],
    );

    blocTest(
      'emits HomeState with status error and unknowError message when call signOut',
      build: () => cubit,
      setUp: () => when(authService.signOut()).thenThrow(Exception()),
      act: (cubit) => [cubit.signOut()],
      expect: () => [
        HomeState(status: BaseStateStatus.loading),
        HomeState(
            status: BaseStateStatus.error,
            callbackMessage: AppLocalizations.current.unknowError)
      ],
    );
  });
}
