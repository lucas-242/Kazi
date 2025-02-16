import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:kazi/app/models/service_type.dart';
import 'package:kazi/app/repositories/service_type_repository/service_type_repository.dart';
import 'package:kazi/app/repositories/services_repository/services_repository.dart';
import 'package:kazi/app/services/auth_service/auth_service.dart';
import 'package:kazi/app/shared/errors/errors.dart';
import 'package:kazi/app/shared/l10n/generated/l10n.dart';
import 'package:kazi/app/shared/utils/base_state.dart';
import 'package:kazi/app/views/service_types/service_types.dart';

import '../../../../mocks/mocks.dart';
import '../../../../utils/test_helper.dart';
import '../services/service_form/service_form_cubit_test.mocks.dart';

@GenerateMocks([ServiceTypeRepository, ServicesRepository, AuthService])
void main() {
  late MockServiceTypeRepository serviceTypeRepository;
  late MockServicesRepository servicesRepository;
  late MockAuthService authService;
  late ServiceTypesCubit cubit;

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

    cubit = ServiceTypesCubit(
        serviceTypeRepository, servicesRepository, authService,);
  });

  group('Call onInit function', () {
    blocTest<ServiceTypesCubit, ServiceTypesState>(
      'emits SettingsState with loaded serviceTypeList and status success when call onInit',
      build: () => cubit,
      act: (cubit) => cubit.onInit(),
      expect: () => [
        ServiceTypesState(
          userId: authService.user!.uid,
          serviceTypeList: serviceTypesMock,
          status: BaseStateStatus.readyToUserInput,
        ),
      ],
    );

    blocTest<ServiceTypesCubit, ServiceTypesState>(
      'emits SettingsState with empty serviceTypeList and status noData when call onInit',
      setUp: () {
        when(serviceTypeRepository.get(any)).thenAnswer((_) async => []);
      },
      build: () => cubit,
      act: (cubit) => cubit.onInit(),
      expect: () => [
        ServiceTypesState(
          userId: authService.user!.uid,
          serviceTypeList: [],
          status: BaseStateStatus.noData,
        ),
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
          userId: authService.user!.uid,
          status: BaseStateStatus.loading,
        ),
        ServiceTypesState(
          userId: authService.user!.uid,
          serviceTypeList: serviceTypesMock,
          status: BaseStateStatus.readyToUserInput,
        ),
      ],
    );

    blocTest<ServiceTypesCubit, ServiceTypesState>(
      'emits SettingsState with status error and callbackMessage = errorToGetServiceTypes when call getServicesType',
      build: () => cubit,
      setUp: () {
        when(serviceTypeRepository.get(any)).thenThrow(
            ExternalError(AppLocalizations.current.errorToGetServiceTypes),);
      },
      act: (cubit) => cubit.getServiceTypes(),
      expect: () => [
        ServiceTypesState(
          userId: authService.user!.uid,
          status: BaseStateStatus.loading,
        ),
        ServiceTypesState(
          userId: authService.user!.uid,
          callbackMessage: AppLocalizations.current.errorToGetServiceTypes,
          status: BaseStateStatus.error,
        ),
      ],
    );

    blocTest<ServiceTypesCubit, ServiceTypesState>(
      'emits SettingsState with status error and callbackMessage = unknowError when call getServicesType',
      build: () => cubit,
      setUp: () {
        when(serviceTypeRepository.get(any)).thenThrow(Exception());
      },
      act: (cubit) => cubit.getServiceTypes(),
      expect: () => [
        ServiceTypesState(
          userId: authService.user!.uid,
          status: BaseStateStatus.loading,
        ),
        ServiceTypesState(
          userId: authService.user!.uid,
          callbackMessage: AppLocalizations.current.unknowError,
          status: BaseStateStatus.error,
        ),
      ],
    );
  });

  group('Add Service Type', () {
    blocTest<ServiceTypesCubit, ServiceTypesState>(
      'emits SettingsState with loaded serviceTypeList and status success when call addServiceType',
      build: () => cubit,
      seed: () => ServiceTypesState(
        userId: authService.user!.uid,
        status: BaseStateStatus.success,
      ),
      act: (cubit) =>
          [cubit.changeServiceType(serviceTypeMock), cubit.addServiceType()],
      expect: () => [
        ServiceTypesState(
          userId: authService.user!.uid,
          serviceType: serviceTypeMock,
          status: BaseStateStatus.success,
        ),
        ServiceTypesState(
          userId: authService.user!.uid,
          serviceType: serviceTypeMock,
          status: BaseStateStatus.loading,
        ),
        ServiceTypesState(
          userId: authService.user!.uid,
          serviceTypeList: [serviceTypeMock],
          status: BaseStateStatus.success,
        ),
      ],
    );
  });

  group('Update Service Type', () {
    blocTest<ServiceTypesCubit, ServiceTypesState>(
      'emits SettingsState with loaded serviceTypeList and status success when call updateServiceType',
      build: () => cubit,
      seed: () => ServiceTypesState(
        userId: authService.user!.uid,
        status: BaseStateStatus.success,
      ),
      act: (cubit) =>
          [cubit.changeServiceType(serviceTypeMock), cubit.updateServiceType()],
      expect: () => [
        ServiceTypesState(
          userId: authService.user!.uid,
          serviceType: serviceTypeMock,
          status: BaseStateStatus.success,
        ),
        ServiceTypesState(
          userId: authService.user!.uid,
          serviceType: serviceTypeMock,
          status: BaseStateStatus.loading,
        ),
        ServiceTypesState(
          userId: authService.user!.uid,
          serviceTypeList: serviceTypesMock,
          status: BaseStateStatus.success,
        ),
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

    blocTest<ServiceTypesCubit, ServiceTypesState>(
      'emits SettingsState with loaded serviceTypeList and status success when call deleteServiceType',
      build: () => cubit,
      seed: () => ServiceTypesState(
        userId: authService.user!.uid,
        serviceTypeList: serviceTypeList,
        status: BaseStateStatus.success,
      ),
      act: (cubit) => [cubit.deleteServiceType(serviceTypeToDelete)],
      expect: () => [
        ServiceTypesState(
          userId: authService.user!.uid,
          serviceTypeList: serviceTypeList,
          status: BaseStateStatus.loading,
        ),
        ServiceTypesState(
          userId: authService.user!.uid,
          serviceTypeList: serviceTypesMock,
          status: BaseStateStatus.success,
        ),
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
        userId: authService.user!.uid,
        serviceType: serviceTypeMock,
        status: BaseStateStatus.noData,
      ),
      act: (cubit) => [cubit.eraseServiceType()],
      expect: () => [
        ServiceTypesState(
          userId: authService.user!.uid,
          status: BaseStateStatus.noData,
        ),
      ],
    );

    blocTest<ServiceTypesCubit, ServiceTypesState>(
      'emits SettingsState with new serviceType with different name when call changeServiceTypeName',
      build: () => cubit,
      seed: () => ServiceTypesState(
        userId: authService.user!.uid,
        serviceType: serviceTypeMock,
        status: BaseStateStatus.noData,
      ),
      act: (cubit) => [cubit.changeServiceTypeName(newName)],
      expect: () => [
        ServiceTypesState(
          userId: authService.user!.uid,
          serviceType: serviceTypeMock.copyWith(name: newName),
          status: BaseStateStatus.noData,
        ),
      ],
    );

    blocTest<ServiceTypesCubit, ServiceTypesState>(
      'emits SettingsState with new serviceType with different defaultValue when call changeServiceTypeDefaultValue',
      build: () => cubit,
      seed: () => ServiceTypesState(
        userId: authService.user!.uid,
        serviceType: serviceTypeMock,
        status: BaseStateStatus.noData,
      ),
      act: (cubit) => [cubit.changeServiceTypeDefaultValue(newDefaultValue)],
      expect: () => [
        ServiceTypesState(
          userId: authService.user!.uid,
          serviceType: serviceTypeMock.copyWith(defaultValue: newDefaultValue),
          status: BaseStateStatus.noData,
        ),
      ],
    );

    blocTest<ServiceTypesCubit, ServiceTypesState>(
      'emits SettingsState with new serviceType with different discountPercent when call changeServiceTypeDiscountPercent',
      build: () => cubit,
      seed: () => ServiceTypesState(
        userId: authService.user!.uid,
        serviceType: serviceTypeMock,
        status: BaseStateStatus.noData,
      ),
      act: (cubit) =>
          [cubit.changeServiceTypeDiscountPercent(newDiscountPercent)],
      expect: () => [
        ServiceTypesState(
          userId: authService.user!.uid,
          serviceType:
              serviceTypeMock.copyWith(discountPercent: newDiscountPercent),
          status: BaseStateStatus.noData,
        ),
      ],
    );
  });
}
