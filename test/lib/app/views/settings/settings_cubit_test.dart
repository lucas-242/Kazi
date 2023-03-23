import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:my_services/app/models/service_type.dart';
import 'package:my_services/app/repositories/service_type_repository/service_type_repository.dart';
import 'package:my_services/app/repositories/services_repository/services_repository.dart';
import 'package:my_services/app/services/auth_service/auth_service.dart';
import 'package:my_services/app/shared/errors/errors.dart';
import 'package:my_services/app/shared/l10n/generated/l10n.dart';
import 'package:my_services/app/shared/utils/base_state.dart';
import 'package:my_services/app/views/settings/settings.dart';

import '../../../../mocks/mocks.dart';
import '../../../../utils/test_helper.dart';
import 'settings_cubit_test.mocks.dart';

@GenerateMocks([ServiceTypeRepository, ServicesRepository, AuthService])
void main() {
  late MockServiceTypeRepository serviceTypeRepository;
  late MockServicesRepository servicesRepository;
  late MockAuthService authService;
  late SettingsCubit cubit;

  TestHelper.loadAppLocalizations();

  setUp(() {
    serviceTypeRepository = MockServiceTypeRepository();
    servicesRepository = MockServicesRepository();
    authService = MockAuthService();

    when(authService.user).thenReturn(userMock);

    when(serviceTypeRepository.get(any))
        .thenAnswer((_) async => serviceTypesMock);
    when(serviceTypeRepository.add(any))
        .thenAnswer((_) async => serviceTypeMock);

    cubit =
        SettingsCubit(serviceTypeRepository, servicesRepository, authService);
  });

  group('Call onInit function', () {
    blocTest<SettingsCubit, SettingsState>(
      'emits SettingsState with loaded serviceTypeList and status success when call onInit',
      build: () => cubit,
      act: (cubit) => cubit.onInit(),
      expect: () => [
        SettingsState(
          userId: authService.user!.uid,
          serviceTypeList: serviceTypesMock,
          status: BaseStateStatus.readyToUserInput,
        )
      ],
    );

    blocTest<SettingsCubit, SettingsState>(
      'emits SettingsState with empty serviceTypeList and status noData when call onInit',
      setUp: () {
        when(serviceTypeRepository.get(any)).thenAnswer((_) async => []);
      },
      build: () => cubit,
      act: (cubit) => cubit.onInit(),
      expect: () => [
        SettingsState(
          userId: authService.user!.uid,
          serviceTypeList: [],
          status: BaseStateStatus.noData,
        )
      ],
    );
  });

  group('Get Service Type', () {
    blocTest<SettingsCubit, SettingsState>(
      'emits SettingsState with loaded serviceTypeList and status success when call getServicesType',
      build: () => cubit,
      act: (cubit) => cubit.getServiceTypes(),
      expect: () => [
        SettingsState(
          userId: authService.user!.uid,
          status: BaseStateStatus.loading,
        ),
        SettingsState(
          userId: authService.user!.uid,
          serviceTypeList: serviceTypesMock,
          status: BaseStateStatus.readyToUserInput,
        )
      ],
    );

    blocTest<SettingsCubit, SettingsState>(
      'emits SettingsState with status error and callbackMessage = errorToGetServiceTypes when call getServicesType',
      build: () => cubit,
      setUp: () {
        when(serviceTypeRepository.get(any)).thenThrow(
            ExternalError(AppLocalizations.current.errorToGetServiceTypes));
      },
      act: (cubit) => cubit.getServiceTypes(),
      expect: () => [
        SettingsState(
          userId: authService.user!.uid,
          status: BaseStateStatus.loading,
        ),
        SettingsState(
          userId: authService.user!.uid,
          callbackMessage: AppLocalizations.current.errorToGetServiceTypes,
          status: BaseStateStatus.error,
        )
      ],
    );

    blocTest<SettingsCubit, SettingsState>(
      'emits SettingsState with status error and callbackMessage = unknowError when call getServicesType',
      build: () => cubit,
      setUp: () {
        when(serviceTypeRepository.get(any)).thenThrow(Exception());
      },
      act: (cubit) => cubit.getServiceTypes(),
      expect: () => [
        SettingsState(
          userId: authService.user!.uid,
          status: BaseStateStatus.loading,
        ),
        SettingsState(
          userId: authService.user!.uid,
          callbackMessage: AppLocalizations.current.unknowError,
          status: BaseStateStatus.error,
        )
      ],
    );
  });

  group('Add Service Type', () {
    blocTest<SettingsCubit, SettingsState>(
      'emits SettingsState with loaded serviceTypeList and status success when call addServiceType',
      build: () => cubit,
      seed: () => SettingsState(
        userId: authService.user!.uid,
        status: BaseStateStatus.success,
      ),
      act: (cubit) =>
          [cubit.changeServiceType(serviceTypeMock), cubit.addServiceType()],
      expect: () => [
        SettingsState(
          userId: authService.user!.uid,
          serviceType: serviceTypeMock,
          status: BaseStateStatus.success,
        ),
        SettingsState(
          userId: authService.user!.uid,
          serviceType: serviceTypeMock,
          status: BaseStateStatus.loading,
        ),
        SettingsState(
          userId: authService.user!.uid,
          serviceTypeList: [serviceTypeMock],
          status: BaseStateStatus.success,
        )
      ],
    );
  });

  group('Update Service Type', () {
    blocTest<SettingsCubit, SettingsState>(
      'emits SettingsState with loaded serviceTypeList and status success when call updateServiceType',
      build: () => cubit,
      seed: () => SettingsState(
        userId: authService.user!.uid,
        status: BaseStateStatus.success,
      ),
      act: (cubit) =>
          [cubit.changeServiceType(serviceTypeMock), cubit.updateServiceType()],
      expect: () => [
        SettingsState(
          userId: authService.user!.uid,
          serviceType: serviceTypeMock,
          status: BaseStateStatus.success,
        ),
        SettingsState(
          userId: authService.user!.uid,
          serviceType: serviceTypeMock,
          status: BaseStateStatus.loading,
        ),
        SettingsState(
          userId: authService.user!.uid,
          serviceTypeList: serviceTypesMock,
          status: BaseStateStatus.success,
        )
      ],
    );
  });

  group('Delete Service Type', () {
    late ServiceType serviceTypeToDelete;
    late List<ServiceType> serviceTypeList;

    setUp(() {
      serviceTypeToDelete = serviceTypeMock.copyWith(id: '123456');
      serviceTypeList = serviceTypesMock..add(serviceTypeToDelete);
      when(servicesRepository.count(any, any)).thenAnswer((_) async => 0);
    });

    blocTest<SettingsCubit, SettingsState>(
      'emits SettingsState with loaded serviceTypeList and status success when call deleteServiceType',
      build: () => cubit,
      seed: () => SettingsState(
        userId: authService.user!.uid,
        serviceTypeList: serviceTypeList,
        status: BaseStateStatus.success,
      ),
      act: (cubit) => [cubit.deleteServiceType(serviceTypeToDelete)],
      expect: () => [
        SettingsState(
          userId: authService.user!.uid,
          serviceTypeList: serviceTypeList,
          status: BaseStateStatus.loading,
        ),
        SettingsState(
          userId: authService.user!.uid,
          serviceTypeList: serviceTypesMock,
          status: BaseStateStatus.success,
        )
      ],
    );
  });

  group('Change properties', () {
    const newName = 'new name';
    const newDefaultValue = 9999.0;
    const newDiscountPercent = 1.0;

    blocTest<SettingsCubit, SettingsState>(
      'emits SettingsState with new serviceType when call eraseServiceType',
      build: () => cubit,
      seed: () => SettingsState(
        userId: authService.user!.uid,
        serviceType: serviceTypeMock,
        status: BaseStateStatus.noData,
      ),
      act: (cubit) => [cubit.eraseServiceType()],
      expect: () => [
        SettingsState(
          userId: authService.user!.uid,
          status: BaseStateStatus.noData,
        )
      ],
    );

    blocTest<SettingsCubit, SettingsState>(
      'emits SettingsState with new serviceType with different name when call changeServiceTypeName',
      build: () => cubit,
      seed: () => SettingsState(
        userId: authService.user!.uid,
        serviceType: serviceTypeMock,
        status: BaseStateStatus.noData,
      ),
      act: (cubit) => [cubit.changeServiceTypeName(newName)],
      expect: () => [
        SettingsState(
          userId: authService.user!.uid,
          serviceType: serviceTypeMock.copyWith(name: newName),
          status: BaseStateStatus.noData,
        )
      ],
    );

    blocTest<SettingsCubit, SettingsState>(
      'emits SettingsState with new serviceType with different defaultValue when call changeServiceTypeDefaultValue',
      build: () => cubit,
      seed: () => SettingsState(
        userId: authService.user!.uid,
        serviceType: serviceTypeMock,
        status: BaseStateStatus.noData,
      ),
      act: (cubit) =>
          [cubit.changeServiceTypeDefaultValue(newDefaultValue.toString())],
      expect: () => [
        SettingsState(
          userId: authService.user!.uid,
          serviceType: serviceTypeMock.copyWith(defaultValue: newDefaultValue),
          status: BaseStateStatus.noData,
        )
      ],
    );

    blocTest<SettingsCubit, SettingsState>(
      'emits SettingsState with new serviceType with different discountPercent when call changeServiceTypeDiscountPercent',
      build: () => cubit,
      seed: () => SettingsState(
        userId: authService.user!.uid,
        serviceType: serviceTypeMock,
        status: BaseStateStatus.noData,
      ),
      act: (cubit) => [
        cubit.changeServiceTypeDiscountPercent(newDiscountPercent.toString())
      ],
      expect: () => [
        SettingsState(
          userId: authService.user!.uid,
          serviceType:
              serviceTypeMock.copyWith(discountPercent: newDiscountPercent),
          status: BaseStateStatus.noData,
        )
      ],
    );
  });
}
