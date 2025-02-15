import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:kazi/app/models/enums.dart';
import 'package:kazi/app/repositories/service_type_repository/service_type_repository.dart';
import 'package:kazi/app/repositories/services_repository/services_repository.dart';
import 'package:kazi/app/services/auth_service/auth_service.dart';
import 'package:kazi/app/services/services_service/local/local_services_service.dart';
import 'package:kazi/app/services/services_service/services_service.dart';
import 'package:kazi/app/services/time_service/local/local_time_service.dart';
import 'package:kazi/app/services/time_service/time_service.dart';
import 'package:kazi/app/shared/errors/errors.dart';
import 'package:kazi/app/shared/l10n/generated/l10n.dart';
import 'package:kazi/app/shared/utils/base_state.dart';
import 'package:kazi/app/views/home/home.dart';

import '../../../../mocks/mocks.dart';
import '../../../../utils/test_helper.dart';
import 'home_cubit_test.mocks.dart';

@GenerateMocks([ServiceTypeRepository, ServicesRepository, AuthService])
void main() {
  late MockServiceTypeRepository serviceTypeRepository;
  late MockServicesRepository servicesRepository;
  late MockAuthService authService;
  late TimeService timeService;
  late ServicesService servicesService;
  late HomeCubit cubit;

  TestHelper.loadAppLocalizations();

  setUp(() {
    serviceTypeRepository = MockServiceTypeRepository();
    servicesRepository = MockServicesRepository();
    authService = MockAuthService();
    timeService = LocalTimeService();
    servicesService = LocalServicesService(timeService);

    when(authService.user).thenReturn(userMock);

    when(serviceTypeRepository.get(any))
        .thenAnswer((_) async => serviceTypesWithIdsMock);

    when(servicesRepository.get(any, any, any))
        .thenAnswer((_) async => servicesWithTypeIdMock);

    cubit = HomeCubit(
      servicesRepository,
      serviceTypeRepository,
      authService,
      servicesService,
    );
  });

  group('Call onInit function', () {
    blocTest(
      'emits HomeState with loaded services ordered by DateDesc and status success when call onInit',
      build: () => cubit,
      act: (cubit) => cubit.onInit(),
      expect: () => [
        HomeState(
          status: BaseStateStatus.success,
          services: servicesService.orderServices(
            servicesWithTypesMock,
            OrderBy.dateDesc,
          ),
        ),
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
        ),
      ],
    );

    blocTest(
      'emits HomeState with status error and callbackMessage = errorToGetServices when call onInit',
      build: () => cubit,
      seed: () => HomeState(status: BaseStateStatus.noData),
      setUp: () {
        when(servicesRepository.get(any, any, any)).thenThrow(
            ExternalError(AppLocalizations.current.errorToGetServices),);
      },
      act: (cubit) => cubit.onInit(),
      expect: () => [
        HomeState(
          callbackMessage: AppLocalizations.current.errorToGetServices,
          status: BaseStateStatus.error,
        ),
      ],
    );

    blocTest(
      'emits HomeState with status error and callbackMessage = errorToGetServiceTypes when call onInit',
      build: () => cubit,
      seed: () => HomeState(status: BaseStateStatus.noData),
      setUp: () {
        when(serviceTypeRepository.get(any)).thenThrow(
            ExternalError(AppLocalizations.current.errorToGetServiceTypes),);
      },
      act: (cubit) => cubit.onInit(),
      expect: () => [
        HomeState(
          callbackMessage: AppLocalizations.current.errorToGetServiceTypes,
          status: BaseStateStatus.error,
        ),
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
        ),
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
        ),
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
}
