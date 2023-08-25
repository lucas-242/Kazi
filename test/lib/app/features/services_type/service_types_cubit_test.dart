import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kazi/app/core/auth/auth.dart';
import 'package:kazi/app/core/errors/errors.dart';
import 'package:kazi/app/core/l10n/generated/l10n.dart';
import 'package:kazi/app/core/utils/base_state.dart';
import 'package:kazi/app/data/repositories/service_type_repository/service_type_repository.dart';
import 'package:kazi/app/data/repositories/services_repository/services_repository.dart';
import 'package:kazi/app/features/service_types/service_types.dart';
import 'package:kazi/app/models/service_type.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../mocks/mocks.dart';
import '../../../../utils/test_helper.dart';
import '../services/service_form/service_form_cubit_test.mocks.dart';

@GenerateMocks([ServiceTypeRepository, ServicesRepository, Auth])
void main() {
  late MockServiceTypeRepository serviceTypeRepository;
  late MockAuth authService;
  late ServiceTypesCubit cubit;

  TestHelper.loadAppLocalizations();

  setUp(() {
    serviceTypeRepository = MockServiceTypeRepository();
    authService = MockAuth();

    when(authService.user).thenReturn(userMock);

    when(serviceTypeRepository.get()).thenAnswer((_) async => serviceTypesMock);
    when(serviceTypeRepository.add(any))
        .thenAnswer((_) async => serviceTypeMock);

    cubit = ServiceTypesCubit(serviceTypeRepository, authService);
  });

  group('Call onInit function', () {
    blocTest<ServiceTypesCubit, ServiceTypesState>(
      'emits SettingsState with loaded serviceTypeList and status success when call onInit',
      build: () => cubit,
      act: (cubit) => cubit.onInit(),
      expect: () => [
        ServiceTypesState(
          userId: authService.user!.id,
          serviceTypeList: serviceTypesMock,
          status: BaseStateStatus.initial,
        )
      ],
    );

    blocTest<ServiceTypesCubit, ServiceTypesState>(
      'emits SettingsState with empty serviceTypeList and status noData when call onInit',
      setUp: () {
        when(serviceTypeRepository.get()).thenAnswer((_) async => []);
      },
      build: () => cubit,
      act: (cubit) => cubit.onInit(),
      expect: () => [
        ServiceTypesState(
          userId: authService.user!.id,
          serviceTypeList: [],
          status: BaseStateStatus.noData,
        )
      ],
    );
  });

  group('Get Service Type', () {
    blocTest<ServiceTypesCubit, ServiceTypesState>(
      'emits SettingsState with loaded serviceTypeList and status success when call getServicesType',
      build: () => cubit,
      act: (cubit) => cubit.getServiceTypes(),
      expect: () => [
        ServiceTypesState(
          userId: authService.user!.id,
          status: BaseStateStatus.loading,
        ),
        ServiceTypesState(
          userId: authService.user!.id,
          serviceTypeList: serviceTypesMock,
          status: BaseStateStatus.initial,
        )
      ],
    );

    blocTest<ServiceTypesCubit, ServiceTypesState>(
      'emits SettingsState with status error and callbackMessage = errorToGetServiceTypes when call getServicesType',
      build: () => cubit,
      setUp: () {
        when(serviceTypeRepository.get()).thenThrow(
            ExternalError(AppLocalizations.current.errorToGetServiceTypes));
      },
      act: (cubit) => cubit.getServiceTypes(),
      expect: () => [
        ServiceTypesState(
          userId: authService.user!.id,
          status: BaseStateStatus.loading,
        ),
        ServiceTypesState(
          userId: authService.user!.id,
          callbackMessage: AppLocalizations.current.errorToGetServiceTypes,
          status: BaseStateStatus.error,
        )
      ],
    );

    blocTest<ServiceTypesCubit, ServiceTypesState>(
      'emits SettingsState with status error and callbackMessage = unknowError when call getServicesType',
      build: () => cubit,
      setUp: () {
        when(serviceTypeRepository.get()).thenThrow(Exception());
      },
      act: (cubit) => cubit.getServiceTypes(),
      expect: () => [
        ServiceTypesState(
          userId: authService.user!.id,
          status: BaseStateStatus.loading,
        ),
        ServiceTypesState(
          userId: authService.user!.id,
          callbackMessage: AppLocalizations.current.errorUnknowError,
          status: BaseStateStatus.error,
        )
      ],
    );
  });

  group('Add Service Type', () {
    blocTest<ServiceTypesCubit, ServiceTypesState>(
      'emits SettingsState with loaded serviceTypeList and status success when call addServiceType',
      build: () => cubit,
      seed: () => ServiceTypesState(
        userId: authService.user!.id,
        status: BaseStateStatus.success,
      ),
      act: (cubit) =>
          [cubit.changeServiceType(serviceTypeMock), cubit.addServiceType()],
      expect: () => [
        ServiceTypesState(
          userId: authService.user!.id,
          serviceType: serviceTypeMock,
          status: BaseStateStatus.success,
        ),
        ServiceTypesState(
          userId: authService.user!.id,
          serviceType: serviceTypeMock,
          status: BaseStateStatus.loading,
        ),
        ServiceTypesState(
          userId: authService.user!.id,
          serviceTypeList: [serviceTypeMock],
          status: BaseStateStatus.success,
        )
      ],
    );
  });

  group('Update Service Type', () {
    blocTest<ServiceTypesCubit, ServiceTypesState>(
      'emits SettingsState with loaded serviceTypeList and status success when call updateServiceType',
      build: () => cubit,
      seed: () => ServiceTypesState(
        userId: authService.user!.id,
        status: BaseStateStatus.success,
      ),
      act: (cubit) =>
          [cubit.changeServiceType(serviceTypeMock), cubit.updateServiceType()],
      expect: () => [
        ServiceTypesState(
          userId: authService.user!.id,
          serviceType: serviceTypeMock,
          status: BaseStateStatus.success,
        ),
        ServiceTypesState(
          userId: authService.user!.id,
          serviceType: serviceTypeMock,
          status: BaseStateStatus.loading,
        ),
        ServiceTypesState(
          userId: authService.user!.id,
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
      serviceTypeToDelete = serviceTypeMock.copyWith(id: 1);
      serviceTypeList = serviceTypesMock..add(serviceTypeToDelete);
    });

    blocTest<ServiceTypesCubit, ServiceTypesState>(
      'emits SettingsState with loaded serviceTypeList and status success when call deleteServiceType',
      build: () => cubit,
      seed: () => ServiceTypesState(
        userId: authService.user!.id,
        serviceTypeList: serviceTypeList,
        status: BaseStateStatus.success,
      ),
      act: (cubit) => [cubit.deleteServiceType(serviceTypeToDelete)],
      expect: () => [
        ServiceTypesState(
          userId: authService.user!.id,
          serviceTypeList: serviceTypeList,
          status: BaseStateStatus.loading,
        ),
        ServiceTypesState(
          userId: authService.user!.id,
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

    blocTest<ServiceTypesCubit, ServiceTypesState>(
      'emits SettingsState with new serviceType when call eraseServiceType',
      build: () => cubit,
      seed: () => ServiceTypesState(
        userId: authService.user!.id,
        serviceType: serviceTypeMock,
        status: BaseStateStatus.noData,
      ),
      act: (cubit) => [cubit.eraseServiceType()],
      expect: () => [
        ServiceTypesState(
          userId: authService.user!.id,
          status: BaseStateStatus.noData,
        )
      ],
    );

    blocTest<ServiceTypesCubit, ServiceTypesState>(
      'emits SettingsState with new serviceType with different name when call changeServiceTypeName',
      build: () => cubit,
      seed: () => ServiceTypesState(
        userId: authService.user!.id,
        serviceType: serviceTypeMock,
        status: BaseStateStatus.noData,
      ),
      act: (cubit) => [cubit.changeServiceTypeName(newName)],
      expect: () => [
        ServiceTypesState(
          userId: authService.user!.id,
          serviceType: serviceTypeMock.copyWith(name: newName),
          status: BaseStateStatus.noData,
        )
      ],
    );

    blocTest<ServiceTypesCubit, ServiceTypesState>(
      'emits SettingsState with new serviceType with different defaultValue when call changeServiceTypeDefaultValue',
      build: () => cubit,
      seed: () => ServiceTypesState(
        userId: authService.user!.id,
        serviceType: serviceTypeMock,
        status: BaseStateStatus.noData,
      ),
      act: (cubit) => [cubit.changeServiceTypeDefaultValue(newDefaultValue)],
      expect: () => [
        ServiceTypesState(
          userId: authService.user!.id,
          serviceType: serviceTypeMock.copyWith(defaultValue: newDefaultValue),
          status: BaseStateStatus.noData,
        )
      ],
    );

    blocTest<ServiceTypesCubit, ServiceTypesState>(
      'emits SettingsState with new serviceType with different discountPercent when call changeServiceTypeDiscountPercent',
      build: () => cubit,
      seed: () => ServiceTypesState(
        userId: authService.user!.id,
        serviceType: serviceTypeMock,
        status: BaseStateStatus.noData,
      ),
      act: (cubit) =>
          [cubit.changeServiceTypeDiscountPercent(newDiscountPercent)],
      expect: () => [
        ServiceTypesState(
          userId: authService.user!.id,
          serviceType:
              serviceTypeMock.copyWith(discountPercent: newDiscountPercent),
          status: BaseStateStatus.noData,
        )
      ],
    );
  });
}
