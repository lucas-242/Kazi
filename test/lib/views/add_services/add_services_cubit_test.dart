import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:my_services/models/dropdown_item.dart';
import 'package:my_services/models/service.dart';
import 'package:my_services/repositories/service_type_repository/service_type_repository.dart';
import 'package:my_services/repositories/services_repository/services_repository.dart';
import 'package:my_services/services/auth_service/auth_service.dart';
import 'package:my_services/shared/errors/errors.dart';
import 'package:my_services/shared/l10n/generated/l10n.dart';
import 'package:my_services/shared/utils/base_state.dart';
import 'package:my_services/views/add_services/add_services.dart';

import '../../../mocks/mocks.dart';
import '../../../utils/test_helper.dart';
import 'add_services_cubit_test.mocks.dart';

@GenerateMocks([ServiceTypeRepository, ServicesRepository, AuthService])
void main() {
  late MockServiceTypeRepository serviceTypeRepository;
  late MockServicesRepository servicesRepository;
  late MockAuthService authService;
  late AddServicesCubit cubit;

  TestHelper.loadAppLocalizations();

  setUp(() {
    serviceTypeRepository = MockServiceTypeRepository();
    servicesRepository = MockServicesRepository();
    authService = MockAuthService();

    when(authService.user).thenReturn(userMock);

    when(serviceTypeRepository.get(any))
        .thenAnswer((_) async => serviceTypesMock);

    cubit = AddServicesCubit(
        servicesRepository, serviceTypeRepository, authService);
  });

  group('Call onInit function', () {
    blocTest(
      'emits AddServicesState with loaded serviceTypes and status success when call onInit',
      build: () => cubit,
      act: (cubit) => cubit.onInit(),
      expect: () => [
        AddServicesState(
          userId: authService.user!.uid,
          serviceTypes: serviceTypesMock,
          status: BaseStateStatus.success,
        )
      ],
    );

    blocTest(
      'emits AddServicesState with empty serviceTypes and status noData when call onInit',
      setUp: () {
        when(serviceTypeRepository.get(any)).thenAnswer((_) async => []);
      },
      build: () => cubit,
      act: (cubit) => cubit.onInit(),
      expect: () => [
        AddServicesState(
          userId: authService.user!.uid,
          status: BaseStateStatus.noData,
        )
      ],
    );

    blocTest(
      'emits AddServicesState with status error and callbackMessage = errorToGetServiceTypes when call onInit',
      build: () => cubit,
      seed: () => AddServicesState(
        userId: authService.user!.uid,
        status: BaseStateStatus.noData,
      ),
      setUp: () {
        when(serviceTypeRepository.get(any)).thenThrow(
            ExternalError(AppLocalizations.current.errorToGetServiceTypes));
      },
      act: (cubit) => cubit.onInit(),
      expect: () => [
        AddServicesState(
          userId: authService.user!.uid,
          callbackMessage: AppLocalizations.current.errorToGetServiceTypes,
          status: BaseStateStatus.error,
        )
      ],
    );

    blocTest(
      'emits AddServicesState with status error and callbackMessage = unknowError when call onInit',
      build: () => cubit,
      setUp: () {
        when(serviceTypeRepository.get(any)).thenThrow(Exception());
      },
      act: (cubit) => cubit.onInit(),
      expect: () => [
        AddServicesState(
          userId: authService.user!.uid,
          callbackMessage: AppLocalizations.current.unknowError,
          status: BaseStateStatus.error,
        )
      ],
    );
  });

  group('Add Service', () {
    const quantityServices = 3;

    setUp(() {
      when(servicesRepository.add(any, any))
          .thenAnswer((_) async => servicesMock);
    });

    blocTest(
      'emits AddServicesState with status success when call addService',
      build: () => cubit,
      seed: () => AddServicesState(
        userId: authService.user!.uid,
        serviceTypes: serviceTypesMock,
        status: BaseStateStatus.success,
      ),
      act: (cubit) => [
        cubit.onChangeService(serviceMock),
        cubit.onChangeServicesQuantity(quantityServices.toString()),
        cubit.addService(),
      ],
      expect: () => [
        AddServicesState(
          userId: authService.user!.uid,
          serviceTypes: serviceTypesMock,
          service: serviceMock,
          status: BaseStateStatus.success,
        ),
        AddServicesState(
          userId: authService.user!.uid,
          serviceTypes: serviceTypesMock,
          quantity: quantityServices,
          service: serviceMock,
          status: BaseStateStatus.success,
        ),
        AddServicesState(
          userId: authService.user!.uid,
          serviceTypes: serviceTypesMock,
          quantity: quantityServices,
          service: serviceMock,
          status: BaseStateStatus.loading,
        ),
        AddServicesState(
          userId: authService.user!.uid,
          serviceTypes: serviceTypesMock,
          status: BaseStateStatus.success,
        )
      ],
    );
  });

  group('Update Service', () {
    blocTest(
      'emits AddServicesState with status success when call updateService',
      build: () => cubit,
      seed: () => AddServicesState(
        userId: authService.user!.uid,
        serviceTypes: serviceTypesMock,
        status: BaseStateStatus.success,
      ),
      act: (cubit) => [
        cubit.onChangeService(serviceMock),
        cubit.updateService(),
      ],
      expect: () => [
        AddServicesState(
          userId: authService.user!.uid,
          serviceTypes: serviceTypesMock,
          service: serviceMock,
          status: BaseStateStatus.success,
        ),
        AddServicesState(
          userId: authService.user!.uid,
          serviceTypes: serviceTypesMock,
          service: serviceMock,
          status: BaseStateStatus.loading,
        ),
        AddServicesState(
          userId: authService.user!.uid,
          serviceTypes: serviceTypesMock,
          status: BaseStateStatus.success,
        )
      ],
    );
  });

  group('Change properties', () {
    const newDiscountPercent = 1.0;
    const newValue = 99.0;
    const newDescription = 'new description';
    final newDateTime = DateTime.now();
    final newServiceType = serviceTypeMock.copyWith(id: 'abc');
    final newDropdownItem =
        DropdownItem(value: newServiceType.id, label: newServiceType.name);

    blocTest(
      'emits AddServicesState with new service with different date when call onChangeServiceDate',
      build: () => cubit,
      seed: () => AddServicesState(
        userId: authService.user!.uid,
        status: BaseStateStatus.noData,
      ),
      act: (cubit) => [cubit.onChangeServiceDate(newDateTime)],
      expect: () => [
        AddServicesState(
          userId: authService.user!.uid,
          service: Service(userId: authService.user!.uid, date: newDateTime),
          status: BaseStateStatus.noData,
        )
      ],
    );

    blocTest(
      'emits AddServicesState with new service with different description when call onChangeServiceDescription',
      build: () => cubit,
      seed: () => AddServicesState(
        userId: authService.user!.uid,
        service: serviceMock,
        status: BaseStateStatus.noData,
      ),
      act: (cubit) => [cubit.onChangeServiceDescription(newDescription)],
      expect: () => [
        AddServicesState(
          userId: authService.user!.uid,
          service: serviceMock.copyWith(description: newDescription),
          status: BaseStateStatus.noData,
        )
      ],
    );

    blocTest(
      'emits AddServicesState with new service with different value when call onChangeServiceValue',
      build: () => cubit,
      seed: () => AddServicesState(
        userId: authService.user!.uid,
        service: serviceMock,
        status: BaseStateStatus.noData,
      ),
      act: (cubit) => [cubit.onChangeServiceValue(newValue.toString())],
      expect: () => [
        AddServicesState(
          userId: authService.user!.uid,
          service: serviceMock.copyWith(value: newValue),
          status: BaseStateStatus.noData,
        )
      ],
    );

    blocTest(
      'emits AddServicesState with new service with different discountPercent when call onChangeServiceDiscount',
      build: () => cubit,
      seed: () => AddServicesState(
        userId: authService.user!.uid,
        service: serviceMock,
        status: BaseStateStatus.noData,
      ),
      act: (cubit) =>
          [cubit.onChangeServiceDiscount(newDiscountPercent.toString())],
      expect: () => [
        AddServicesState(
          userId: authService.user!.uid,
          service: serviceMock.copyWith(discountPercent: newDiscountPercent),
          status: BaseStateStatus.noData,
        )
      ],
    );

    blocTest(
      'emits AddServicesState with new service with different discountPercent when call onChangeServiceType',
      build: () => cubit,
      seed: () => AddServicesState(
        userId: authService.user!.uid,
        serviceTypes: serviceTypesMock..add(newServiceType),
        service: serviceMock,
        status: BaseStateStatus.noData,
      ),
      act: (cubit) => [cubit.onChangeServiceType(newDropdownItem)],
      expect: () => [
        AddServicesState(
          userId: authService.user!.uid,
          serviceTypes: serviceTypesMock..add(newServiceType),
          service: serviceMock.copyWith(typeId: newDropdownItem.value),
          status: BaseStateStatus.noData,
        )
      ],
    );
  });
}
