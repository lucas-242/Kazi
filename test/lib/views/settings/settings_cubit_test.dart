import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:my_services/repositories/service_type_repository/service_type_repository.dart';
import 'package:my_services/repositories/services_repository/services_repository.dart';
import 'package:my_services/services/auth_service/auth_service.dart';
import 'package:my_services/shared/utils/base_state.dart';
import 'package:my_services/views/settings/settings.dart';

import '../../../mocks/mocks.dart';
import 'settings_cubit_test.mocks.dart';

@GenerateMocks([ServiceTypeRepository, ServicesRepository, AuthService])
void main() {
  late MockServiceTypeRepository serviceTypeRepository;
  late MockServicesRepository serviceRepository;
  late MockAuthService authService;
  late SettingsCubit cubit;

  setUp(() {
    serviceTypeRepository = MockServiceTypeRepository();
    serviceRepository = MockServicesRepository();
    authService = MockAuthService();

    when(authService.user).thenReturn(userMock);
    when(serviceTypeRepository.get(any))
        .thenAnswer((_) async => serviceTypesMock);
    when(serviceTypeRepository.add(any))
        .thenAnswer((_) async => serviceTypeMock);

    cubit =
        SettingsCubit(serviceTypeRepository, serviceRepository, authService);
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
          status: BaseStateStatus.success,
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
          status: BaseStateStatus.success,
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
}
