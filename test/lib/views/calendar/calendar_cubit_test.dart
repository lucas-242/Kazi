import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:my_services/models/enums.dart';
import 'package:my_services/models/service.dart';
import 'package:my_services/repositories/service_type_repository/service_type_repository.dart';
import 'package:my_services/repositories/services_repository/firebase/models/firebase_service_model.dart';
import 'package:my_services/repositories/services_repository/services_repository.dart';
import 'package:my_services/services/auth_service/auth_service.dart';
import 'package:my_services/shared/errors/errors.dart';
import 'package:my_services/shared/l10n/generated/l10n.dart';
import 'package:my_services/shared/utils/base_state.dart';
import 'package:my_services/views/calendar/calendar.dart';

import '../../../mocks/mocks.dart';
import '../../../utils/test_helper.dart';
import 'calendar_cubit_test.mocks.dart';

@GenerateMocks([ServiceTypeRepository, ServicesRepository, AuthService])
void main() {
  late MockServiceTypeRepository serviceTypeRepository;
  late MockServicesRepository servicesRepository;
  late MockAuthService authService;
  late CalendarCubit cubit;

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

    cubit =
        CalendarCubit(servicesRepository, serviceTypeRepository, authService);
  });

  group('Call onInit function', () {
    blocTest(
      'emits CalendarState with loaded services and status success when call onInit',
      build: () => cubit,
      act: (cubit) => cubit.onInit(),
      expect: () => [
        CalendarState(
          status: BaseStateStatus.success,
          services: servicesWithTypesMock,
        )
      ],
    );

    blocTest(
      'emits CalendarState with empty services and status noData when call onInit',
      setUp: () {
        when(servicesRepository.get(any, any, any)).thenAnswer((_) async => []);
      },
      build: () => cubit,
      act: (cubit) => cubit.onInit(),
      expect: () => [
        CalendarState(
          status: BaseStateStatus.noData,
        )
      ],
    );

    blocTest(
      'emits CalendarState with status error and callbackMessage = errorToGetServices when call onInit',
      build: () => cubit,
      seed: () => CalendarState(status: BaseStateStatus.noData),
      setUp: () {
        when(servicesRepository.get(any, any, any)).thenThrow(
            ExternalError(AppLocalizations.current.errorToGetServices));
      },
      act: (cubit) => cubit.onInit(),
      expect: () => [
        CalendarState(
          callbackMessage: AppLocalizations.current.errorToGetServices,
          status: BaseStateStatus.error,
        )
      ],
    );

    blocTest(
      'emits CalendarState with status error and callbackMessage = errorToGetServiceTypes when call onInit',
      build: () => cubit,
      seed: () => CalendarState(status: BaseStateStatus.noData),
      setUp: () {
        when(serviceTypeRepository.get(any)).thenThrow(
            ExternalError(AppLocalizations.current.errorToGetServiceTypes));
      },
      act: (cubit) => cubit.onInit(),
      expect: () => [
        CalendarState(
          callbackMessage: AppLocalizations.current.errorToGetServiceTypes,
          status: BaseStateStatus.error,
        )
      ],
    );

    blocTest(
      'emits CalendarState with status error and callbackMessage = unknowError when call onInit',
      build: () => cubit,
      setUp: () {
        when(serviceTypeRepository.get(any)).thenThrow(Exception());
      },
      act: (cubit) => cubit.onInit(),
      expect: () => [
        CalendarState(
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
      'emits CalendarState with loaded services and status success when call deleteService',
      build: () => cubit,
      seed: () => CalendarState(
        services: serviceList,
        status: BaseStateStatus.success,
      ),
      act: (cubit) => [cubit.deleteService(serviceToDelete)],
      expect: () => [
        CalendarState(
          services: serviceList,
          status: BaseStateStatus.loading,
        ),
        CalendarState(
          services: servicesWithTypeIdMock,
          status: BaseStateStatus.success,
        )
      ],
    );
  });

  group('Call onRefresh function', () {
    blocTest(
      'emits CalendarState with loaded services and status success when call onRefresh',
      build: () => cubit,
      act: (cubit) => cubit.onRefresh(),
      expect: () => [
        CalendarState(status: BaseStateStatus.loading),
        CalendarState(
          status: BaseStateStatus.success,
          services: servicesWithTypesMock,
        )
      ],
    );
  });

  group('Call Change properties', () {
    late DateTime newStartDateTime;
    late DateTime newEndDateTime;

    setUp(() {
      newStartDateTime = DateTime(2022, 1, 1);
      newEndDateTime = DateTime(2022, 1, 12);
    });

    blocTest(
      'emits CalendarState with new services with different dates when call onChangeDate',
      build: () => cubit,
      act: (cubit) => [cubit.onChangeDate(newStartDateTime, newEndDateTime)],
      expect: () => [
        CalendarState(
          status: BaseStateStatus.loading,
          startDate: newStartDateTime,
          endDate: newEndDateTime,
          selectedFastSearch: FastSearch.custom,
        ),
        CalendarState(
          startDate: newStartDateTime,
          endDate: newEndDateTime,
          services: servicesWithTypesMock,
          status: BaseStateStatus.success,
          selectedFastSearch: FastSearch.custom,
        )
      ],
    );

    blocTest(
      'emits CalendarState with new services with different selectedFastSearch when call onChageSelectedFastSearch',
      build: () => cubit,
      setUp: () {
        newStartDateTime = DateTime(2022, 12, 1);
        newEndDateTime = DateTime(2022, 12, 15, 23, 59, 59);
      },
      act: (cubit) => [cubit.onChageSelectedFastSearch(FastSearch.fortnight)],
      expect: () => [
        CalendarState(
          status: BaseStateStatus.loading,
          startDate: newStartDateTime,
          endDate: newEndDateTime,
          selectedFastSearch: FastSearch.fortnight,
        ),
        CalendarState(
          startDate: newStartDateTime,
          endDate: newEndDateTime,
          services: servicesWithTypesMock,
          status: BaseStateStatus.success,
          selectedFastSearch: FastSearch.fortnight,
        )
      ],
    );

    blocTest(
      'emits CalendarState with new services and status success when call onChangeServices',
      build: () => cubit,
      act: (cubit) => [cubit.onChangeServices()],
      expect: () => [
        CalendarState(status: BaseStateStatus.loading),
        CalendarState(
          services: servicesWithTypesMock,
          status: BaseStateStatus.success,
        )
      ],
    );
  });

  group('Call onChangeOrderBy', () {
    blocTest(
      'emits CalendarState with services ordered dateDesc and status success when call onChangeOrderBy',
      build: () => cubit,
      act: (cubit) => [cubit.onChangeOrderBy(OrderBy.dateDesc)],
      seed: () => CalendarState(
        services: servicesWithTypesMock,
        status: BaseStateStatus.success,
      ),
      expect: () => [
        CalendarState(
          services: servicesWithTypesMock,
          status: BaseStateStatus.success,
          selectedOrderBy: OrderBy.dateDesc,
        )
      ],
    );
  });

  group('State properties', () {
    test('totalValue should be 210', () {
      final state = CalendarState(
        services: servicesWithTypesMock,
        status: BaseStateStatus.success,
        selectedOrderBy: OrderBy.dateDesc,
      );

      expect(state.totalValue, 210);
    });

    test('totalWithDiscount should be 105', () {
      final state = CalendarState(
        services: servicesWithTypesMock,
        status: BaseStateStatus.success,
        selectedOrderBy: OrderBy.dateDesc,
      );

      expect(state.totalWithDiscount, 105);
    });

    test('totalDiscounted should be 105', () {
      final state = CalendarState(
        services: servicesWithTypesMock,
        status: BaseStateStatus.success,
        selectedOrderBy: OrderBy.dateDesc,
      );

      expect(state.totalDiscounted, 105);
    });
  });
}
