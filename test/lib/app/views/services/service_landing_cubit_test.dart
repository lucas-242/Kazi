// ignore_for_file: avoid_redundant_argument_values

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:kazi/app/models/enums.dart';
import 'package:kazi/app/models/service.dart';
import 'package:kazi/app/repositories/service_type_repository/service_type_repository.dart';
import 'package:kazi/app/repositories/services_repository/firebase/models/firebase_service_model.dart';
import 'package:kazi/app/repositories/services_repository/services_repository.dart';
import 'package:kazi/app/services/auth_service/auth_service.dart';
import 'package:kazi/app/services/services_service/local/local_services_service.dart';
import 'package:kazi/app/services/services_service/services_service.dart';
import 'package:kazi/app/services/time_service/local/local_time_service.dart';
import 'package:kazi/app/shared/errors/errors.dart';
import 'package:kazi/app/shared/l10n/generated/l10n.dart';
import 'package:kazi/app/shared/utils/base_state.dart';
import 'package:kazi/app/views/services/services.dart';

import '../../../../mocks/mocks.dart';
import '../../../../utils/test_helper.dart';
import 'service_landing_cubit_test.mocks.dart';

@GenerateMocks([ServiceTypeRepository, ServicesRepository, AuthService])
void main() {
  late MockServiceTypeRepository serviceTypeRepository;
  late MockServicesRepository servicesRepository;
  late MockAuthService authService;
  late LocalTimeService timeService;
  late ServicesService servicesService;
  late ServiceLandingCubit cubit;

  TestHelper.loadAppLocalizations();

  setUp(() {
    serviceTypeRepository = MockServiceTypeRepository();
    servicesRepository = MockServicesRepository();
    timeService = LocalTimeService(serviceMock.date);
    servicesService = LocalServicesService(timeService);
    authService = MockAuthService();

    when(authService.user).thenReturn(userMock);

    when(serviceTypeRepository.get(any))
        .thenAnswer((_) async => serviceTypesWithIdsMock);

    when(servicesRepository.get(any, any, any))
        .thenAnswer((_) async => servicesWithTypeIdMock);

    cubit = ServiceLandingCubit(servicesRepository, serviceTypeRepository,
        authService, servicesService,);
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
          services: servicesService.orderServices(
            servicesWithTypesMock,
            OrderBy.alphabetical,
          ),
          startDate: servicesService.now,
          endDate: servicesService.now
              .copyWith(day: 31, hour: 23, minute: 59, second: 59),
        ),
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
          startDate: servicesService.now,
          endDate: servicesService.now
              .copyWith(day: 31, hour: 23, minute: 59, second: 59),
        ),
      ],
    );

    blocTest(
      'emits ServiceLandingState with status error and callbackMessage = errorToGetServices when call onInit',
      build: () => cubit,
      seed: () => ServiceLandingState(
        status: BaseStateStatus.noData,
        startDate: servicesService.now,
        endDate: servicesService.now,
      ),
      setUp: () {
        when(servicesRepository.get(any, any, any)).thenThrow(
            ExternalError(AppLocalizations.current.errorToGetServices),);
      },
      act: (cubit) => cubit.onInit(),
      expect: () => [
        ServiceLandingState(
          callbackMessage: AppLocalizations.current.errorToGetServices,
          status: BaseStateStatus.error,
          startDate: servicesService.now,
          endDate: servicesService.now,
        ),
      ],
    );

    blocTest(
      'emits ServiceLandingState with status error and callbackMessage = errorToGetServiceTypes when call onInit',
      build: () => cubit,
      seed: () => ServiceLandingState(
        status: BaseStateStatus.noData,
        startDate: servicesService.now,
        endDate: servicesService.now,
      ),
      setUp: () {
        when(serviceTypeRepository.get(any)).thenThrow(
            ExternalError(AppLocalizations.current.errorToGetServiceTypes),);
      },
      act: (cubit) => cubit.onInit(),
      expect: () => [
        ServiceLandingState(
          callbackMessage: AppLocalizations.current.errorToGetServiceTypes,
          status: BaseStateStatus.error,
          startDate: servicesService.now,
          endDate: servicesService.now,
        ),
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
          startDate: servicesService.now,
          endDate: servicesService.now,
        ),
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
          servicesService.orderServices(resultList, OrderBy.alphabetical);
    });

    blocTest(
      'emits ServiceLandingState with loaded services and status success when call deleteService',
      build: () => cubit,
      seed: () => ServiceLandingState(
        services: serviceList,
        status: BaseStateStatus.success,
        startDate: servicesService.now,
        endDate: servicesService.now,
      ),
      act: (cubit) => [cubit.deleteService(serviceToDelete)],
      expect: () => [
        ServiceLandingState(
          services: serviceList,
          status: BaseStateStatus.loading,
          startDate: servicesService.now,
          endDate: servicesService.now,
        ),
        ServiceLandingState(
          services: resultList,
          status: BaseStateStatus.success,
          startDate: servicesService.now,
          endDate: servicesService.now,
        ),
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
            startDate: servicesService.now,
            endDate: servicesService.now,),
        ServiceLandingState(
          status: BaseStateStatus.success,
          services: servicesService.orderServices(
            servicesWithTypesMock,
            OrderBy.alphabetical,
          ),
          startDate: servicesService.now,
          endDate: servicesService.now
              .copyWith(day: 31, hour: 23, minute: 59, second: 59),
        ),
      ],
    );
  });

  group('Call Change properties', () {
    late DateTime newStartDateTime;
    late DateTime newEndDateTime;
    late LocalTimeService localTimeService;

    setUp(() {
      localTimeService = LocalTimeService(DateTime(2022, 12, 12));
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
          services: servicesService.orderServices(
            servicesWithTypesMock,
            OrderBy.alphabetical,
          ),
          status: BaseStateStatus.success,
          fastSearch: FastSearch.custom,
          didFiltersChange: true,
        ),
      ],
    );

    blocTest(
      'emits ServiceLandingState with new services with different selectedFastSearch and didFiltersChange when call onApplyFilters with FastSearch',
      build: () => ServiceLandingCubit(
          servicesRepository,
          serviceTypeRepository,
          authService,
          LocalServicesService(localTimeService),),
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
        ),
      ],
    );

    blocTest(
      'emits ServiceLandingState with new services and status success when call onChangeServices',
      build: () => cubit,
      act: (cubit) => [cubit.onChangeServices()],
      expect: () => [
        ServiceLandingState(
          status: BaseStateStatus.loading,
          startDate: servicesService.now,
          endDate: servicesService.now,
        ),
        ServiceLandingState(
          services: servicesWithTypesMock,
          status: BaseStateStatus.success,
          startDate: servicesService.now,
          endDate: servicesService.now,
        ),
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
        startDate: servicesService.now,
        endDate: servicesService.now,
      ),
      expect: () => [
        ServiceLandingState(
          services: servicesWithTypesMock,
          status: BaseStateStatus.success,
          selectedOrderBy: OrderBy.dateDesc,
          startDate: servicesService.now,
          endDate: servicesService.now,
        ),
      ],
    );
  });

  group('State properties', () {
    test('totalValue should be 210', () {
      final state = ServiceLandingState(
        services: servicesWithTypesMock,
        status: BaseStateStatus.success,
        selectedOrderBy: OrderBy.dateDesc,
        startDate: servicesService.now,
        endDate: servicesService.now,
      );

      expect(state.totalValue, 210);
    });

    test('totalWithDiscount should be 105', () {
      final state = ServiceLandingState(
        services: servicesWithTypesMock,
        status: BaseStateStatus.success,
        selectedOrderBy: OrderBy.dateDesc,
        startDate: servicesService.now,
        endDate: servicesService.now,
      );

      expect(state.totalWithDiscount, 105);
    });

    test('totalDiscounted should be 105', () {
      final state = ServiceLandingState(
        services: servicesWithTypesMock,
        status: BaseStateStatus.success,
        selectedOrderBy: OrderBy.dateDesc,
        startDate: servicesService.now,
        endDate: servicesService.now,
      );

      expect(state.totalDiscounted, 105);
    });
  });
}
