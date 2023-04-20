// ignore_for_file: avoid_redundant_argument_values

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
import 'package:my_services/app/services/time_service/time_service.dart';
import 'package:my_services/app/shared/errors/errors.dart';
import 'package:my_services/app/shared/l10n/generated/l10n.dart';
import 'package:my_services/app/shared/utils/base_state.dart';
import 'package:my_services/app/shared/utils/service_helper.dart';
import 'package:my_services/app/views/services/services.dart';

import '../../../../mocks/mocks.dart';
import '../../../../utils/test_helper.dart';
import 'service_landing_cubit_test.mocks.dart';

@GenerateMocks([ServiceTypeRepository, ServicesRepository, AuthService])
void main() {
  late MockServiceTypeRepository serviceTypeRepository;
  late MockServicesRepository servicesRepository;
  late MockAuthService authService;
  late LocalTimeService timeService;
  late ServiceLandingCubit cubit;

  TestHelper.loadAppLocalizations();

  setUp(() {
    serviceTypeRepository = MockServiceTypeRepository();
    servicesRepository = MockServicesRepository();
    timeService = LocalTimeService(serviceMock.date);
    authService = MockAuthService();

    when(authService.user).thenReturn(userMock);

    when(serviceTypeRepository.get(any))
        .thenAnswer((_) async => serviceTypesWithIdsMock);

    when(servicesRepository.get(any, any, any))
        .thenAnswer((_) async => servicesWithTypeIdMock);

    cubit = ServiceLandingCubit(
        servicesRepository, serviceTypeRepository, authService, timeService);
  });

  group('Call onInit function', () {
    blocTest(
      '''emits ServiceLandingState with loaded services 
      ordered alphabetical and status success when call onInit''',
      build: () => cubit,
      act: (cubit) => cubit.onInit(),
      expect: () => [
        ServiceLandingState(
          status: BaseStateStatus.success,
          services: ServiceHelper.orderServices(
            servicesWithTypesMock,
            OrderBy.alphabetical,
          ),
          startDate: timeService.nowWithoutTime,
          endDate: timeService.nowWithoutTime
              .copyWith(day: 31, hour: 23, minute: 59, second: 59),
        )
      ],
    );

    blocTest(
      'emits ServiceLandingState with empty services and status noData when call onInit',
      setUp: () {
        when(servicesRepository.get(any, any, any)).thenAnswer((_) async => []);
      },
      build: () => cubit,
      act: (cubit) => cubit.onInit(),
      expect: () => [
        ServiceLandingState(
          status: BaseStateStatus.noData,
          startDate: timeService.nowWithoutTime,
          endDate: timeService.nowWithoutTime
              .copyWith(day: 31, hour: 23, minute: 59, second: 59),
        )
      ],
    );

    blocTest(
      'emits ServiceLandingState with status error and callbackMessage = errorToGetServices when call onInit',
      build: () => cubit,
      seed: () => ServiceLandingState(
        status: BaseStateStatus.noData,
        startDate: timeService.nowWithoutTime,
        endDate: timeService.nowWithoutTime,
      ),
      setUp: () {
        when(servicesRepository.get(any, any, any)).thenThrow(
            ExternalError(AppLocalizations.current.errorToGetServices));
      },
      act: (cubit) => cubit.onInit(),
      expect: () => [
        ServiceLandingState(
          callbackMessage: AppLocalizations.current.errorToGetServices,
          status: BaseStateStatus.error,
          startDate: timeService.nowWithoutTime,
          endDate: timeService.nowWithoutTime,
        )
      ],
    );

    blocTest(
      'emits ServiceLandingState with status error and callbackMessage = errorToGetServiceTypes when call onInit',
      build: () => cubit,
      seed: () => ServiceLandingState(
        status: BaseStateStatus.noData,
        startDate: timeService.nowWithoutTime,
        endDate: timeService.nowWithoutTime,
      ),
      setUp: () {
        when(serviceTypeRepository.get(any)).thenThrow(
            ExternalError(AppLocalizations.current.errorToGetServiceTypes));
      },
      act: (cubit) => cubit.onInit(),
      expect: () => [
        ServiceLandingState(
          callbackMessage: AppLocalizations.current.errorToGetServiceTypes,
          status: BaseStateStatus.error,
          startDate: timeService.nowWithoutTime,
          endDate: timeService.nowWithoutTime,
        )
      ],
    );

    blocTest(
      'emits ServiceLandingState with status error and callbackMessage = unknowError when call onInit',
      build: () => cubit,
      setUp: () {
        when(serviceTypeRepository.get(any)).thenThrow(Exception());
      },
      act: (cubit) => cubit.onInit(),
      expect: () => [
        ServiceLandingState(
          callbackMessage: AppLocalizations.current.unknowError,
          status: BaseStateStatus.error,
          startDate: timeService.nowWithoutTime,
          endDate: timeService.nowWithoutTime,
        )
      ],
    );
  });

  group('Call delete Service Type', () {
    late FirebaseServiceModel serviceToDelete;
    late List<Service> serviceList;
    late List<Service> resultList;

    setUp(() {
      serviceToDelete = serviceMock.copyWith(id: '123456', typeId: '1');
      serviceList = List.from(servicesWithTypeIdMock)..add(serviceToDelete);
      resultList = List.from(servicesWithTypesMock);
      resultList =
          ServiceHelper.orderServices(resultList, OrderBy.alphabetical);
    });

    blocTest(
      'emits ServiceLandingState with loaded services and status success when call deleteService',
      build: () => cubit,
      seed: () => ServiceLandingState(
        services: serviceList,
        status: BaseStateStatus.success,
        startDate: timeService.nowWithoutTime,
        endDate: timeService.nowWithoutTime,
      ),
      act: (cubit) => [cubit.deleteService(serviceToDelete)],
      expect: () => [
        ServiceLandingState(
          services: serviceList,
          status: BaseStateStatus.loading,
          startDate: timeService.nowWithoutTime,
          endDate: timeService.nowWithoutTime,
        ),
        ServiceLandingState(
          services: resultList,
          status: BaseStateStatus.success,
          startDate: timeService.nowWithoutTime,
          endDate: timeService.nowWithoutTime,
        )
      ],
    );
  });

  group('Call onRefresh function', () {
    blocTest(
      '''emits ServiceLandingState with loaded services 
      and status success when call onRefresh''',
      build: () => cubit,
      act: (cubit) => cubit.onRefresh(),
      expect: () => [
        ServiceLandingState(
            status: BaseStateStatus.loading,
            startDate: timeService.nowWithoutTime,
            endDate: timeService.nowWithoutTime),
        ServiceLandingState(
          status: BaseStateStatus.success,
          services: ServiceHelper.orderServices(
            servicesWithTypesMock,
            OrderBy.alphabetical,
          ),
          startDate: timeService.nowWithoutTime,
          endDate: timeService.nowWithoutTime
              .copyWith(day: 31, hour: 23, minute: 59, second: 59),
        )
      ],
    );
  });

  group('Call Change properties', () {
    late DateTime newStartDateTime;
    late DateTime newEndDateTime;
    late DateTime today;

    setUp(() {
      today = DateTime(2022, 12, 12);
      newStartDateTime = DateTime(2022, 1, 1);
      newEndDateTime = DateTime(2022, 1, 12);
    });

    blocTest(
      '''emits ServiceLandingState with new services 
      with different dates and didFiltersChange when call onApplyFilters with dates''',
      build: () => cubit,
      act: (cubit) =>
          [cubit.onApplyFilters(null, newStartDateTime, newEndDateTime)],
      expect: () => [
        ServiceLandingState(
          status: BaseStateStatus.loading,
          startDate: newStartDateTime,
          endDate: newEndDateTime,
          fastSearch: FastSearch.custom,
          didFiltersChange: true,
        ),
        ServiceLandingState(
          startDate: newStartDateTime,
          endDate: newEndDateTime,
          services: ServiceHelper.orderServices(
            servicesWithTypesMock,
            OrderBy.alphabetical,
          ),
          status: BaseStateStatus.success,
          fastSearch: FastSearch.custom,
          didFiltersChange: true,
        )
      ],
    );

    blocTest(
      'emits ServiceLandingState with new services with different selectedFastSearch and didFiltersChange when call onApplyFilters with FastSearch',
      build: () => ServiceLandingCubit(
        servicesRepository,
        serviceTypeRepository,
        authService,
        LocalTimeService(today),
      ),
      setUp: () {
        newStartDateTime = DateTime(2022, 12, 1);
        newEndDateTime = DateTime(2022, 12, 15, 23, 59, 59);
      },
      act: (cubit) => [cubit.onApplyFilters(FastSearch.fortnight)],
      expect: () => [
        ServiceLandingState(
          status: BaseStateStatus.loading,
          startDate: newStartDateTime,
          endDate: newEndDateTime,
          fastSearch: FastSearch.fortnight,
          didFiltersChange: true,
        ),
        ServiceLandingState(
          startDate: newStartDateTime,
          endDate: newEndDateTime,
          services: servicesWithTypesMock,
          status: BaseStateStatus.success,
          fastSearch: FastSearch.fortnight,
          didFiltersChange: true,
        )
      ],
    );

    blocTest(
      'emits ServiceLandingState with new services and status success when call onChangeServices',
      build: () => cubit,
      act: (cubit) => [cubit.onChangeServices()],
      expect: () => [
        ServiceLandingState(
          status: BaseStateStatus.loading,
          startDate: timeService.nowWithoutTime,
          endDate: timeService.nowWithoutTime,
        ),
        ServiceLandingState(
          services: servicesWithTypesMock,
          status: BaseStateStatus.success,
          startDate: timeService.nowWithoutTime,
          endDate: timeService.nowWithoutTime,
        )
      ],
    );
  });

  group('Call onChangeOrderBy', () {
    blocTest(
      'emits ServiceLandingState with services ordered dateDesc and status success when call onChangeOrderBy',
      build: () => cubit,
      act: (cubit) => [cubit.onChangeOrderBy(OrderBy.dateDesc)],
      seed: () => ServiceLandingState(
        services: servicesWithTypesMock,
        status: BaseStateStatus.success,
        startDate: timeService.nowWithoutTime,
        endDate: timeService.nowWithoutTime,
      ),
      expect: () => [
        ServiceLandingState(
          services: servicesWithTypesMock,
          status: BaseStateStatus.success,
          selectedOrderBy: OrderBy.dateDesc,
          startDate: timeService.nowWithoutTime,
          endDate: timeService.nowWithoutTime,
        )
      ],
    );
  });

  group('State properties', () {
    test('totalValue should be 210', () {
      final state = ServiceLandingState(
        services: servicesWithTypesMock,
        status: BaseStateStatus.success,
        selectedOrderBy: OrderBy.dateDesc,
        startDate: timeService.nowWithoutTime,
        endDate: timeService.nowWithoutTime,
      );

      expect(state.totalValue, 210);
    });

    test('totalWithDiscount should be 105', () {
      final state = ServiceLandingState(
        services: servicesWithTypesMock,
        status: BaseStateStatus.success,
        selectedOrderBy: OrderBy.dateDesc,
        startDate: timeService.nowWithoutTime,
        endDate: timeService.nowWithoutTime,
      );

      expect(state.totalWithDiscount, 105);
    });

    test('totalDiscounted should be 105', () {
      final state = ServiceLandingState(
        services: servicesWithTypesMock,
        status: BaseStateStatus.success,
        selectedOrderBy: OrderBy.dateDesc,
        startDate: timeService.nowWithoutTime,
        endDate: timeService.nowWithoutTime,
      );

      expect(state.totalDiscounted, 105);
    });
  });
}