import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:kazi/app/models/dropdown_item.dart';
import 'package:kazi/app/models/service.dart';
import 'package:kazi/app/repositories/service_type_repository/service_type_repository.dart';
import 'package:kazi/app/repositories/services_repository/services_repository.dart';
import 'package:kazi/app/services/auth_service/auth_service.dart';
import 'package:kazi/app/shared/errors/errors.dart';
import 'package:kazi/app/shared/l10n/generated/l10n.dart';
import 'package:kazi/app/shared/utils/base_state.dart';
import 'package:kazi/app/views/services/services.dart';

import '../../../../../mocks/mocks.dart';
import '../../../../../utils/test_helper.dart';
import 'service_form_cubit_test.mocks.dart';

@GenerateMocks([ServiceTypeRepository, ServicesRepository, AuthService])
void main() {
  late MockServiceTypeRepository serviceTypeRepository;
  late MockServicesRepository servicesRepository;
  late MockAuthService authService;
  late ServiceFormCubit cubit;

  TestHelper.loadAppLocalizations();

  setUp(() {
    serviceTypeRepository = MockServiceTypeRepository();
    servicesRepository = MockServicesRepository();
    authService = MockAuthService();

    when(authService.user).thenReturn(userMock);

    when(serviceTypeRepository.get(any))
        .thenAnswer((_) async => serviceTypesMock);

    cubit = ServiceFormCubit(
        servicesRepository, serviceTypeRepository, authService,);
  });

  group('Call onInit function', () {
    blocTest(
      'emits ServiceFormState with loaded serviceTypes when call onInit',
      build: () => cubit,
      act: (cubit) => cubit.onInit(),
      expect: () => [
        ServiceFormState(
          userId: authService.user!.uid,
          status: BaseStateStatus.loading,
        ),
        ServiceFormState(
          userId: authService.user!.uid,
          serviceTypes: serviceTypesMock,
          status: BaseStateStatus.readyToUserInput,
        ),
      ],
    );

    blocTest(
      'emits ServiceFormState with loaded serviceTypes and Service when call onInit',
      build: () => cubit,
      act: (cubit) => cubit.onInit(serviceMock),
      expect: () => [
        ServiceFormState(
          userId: authService.user!.uid,
          status: BaseStateStatus.loading,
          service: serviceMock,
        ),
        ServiceFormState(
          userId: authService.user!.uid,
          serviceTypes: serviceTypesMock,
          status: BaseStateStatus.readyToUserInput,
          service: serviceMock,
        ),
      ],
    );

    blocTest(
      'emits ServiceFormState with empty serviceTypes and status noData when call onInit',
      setUp: () {
        when(serviceTypeRepository.get(any)).thenAnswer((_) async => []);
      },
      build: () => cubit,
      act: (cubit) => cubit.onInit(),
      expect: () => [
        ServiceFormState(
          userId: authService.user!.uid,
          status: BaseStateStatus.loading,
        ),
        ServiceFormState(
          userId: authService.user!.uid,
          status: BaseStateStatus.noData,
        ),
      ],
    );

    blocTest(
      'emits ServiceFormState with status error and callbackMessage = errorToGetServiceTypes when call onInit',
      build: () => cubit,
      seed: () => ServiceFormState(
        userId: authService.user!.uid,
        status: BaseStateStatus.noData,
      ),
      setUp: () {
        when(serviceTypeRepository.get(any)).thenThrow(
            ExternalError(AppLocalizations.current.errorToGetServiceTypes),);
      },
      act: (cubit) => cubit.onInit(),
      expect: () => [
        ServiceFormState(
          userId: authService.user!.uid,
          status: BaseStateStatus.loading,
        ),
        ServiceFormState(
          userId: authService.user!.uid,
          callbackMessage: AppLocalizations.current.errorToGetServiceTypes,
          status: BaseStateStatus.error,
        ),
      ],
    );

    blocTest(
      'emits ServiceFormState with status error and callbackMessage = unknowError when call onInit',
      build: () => cubit,
      setUp: () {
        when(serviceTypeRepository.get(any)).thenThrow(Exception());
      },
      act: (cubit) => cubit.onInit(),
      expect: () => [
        ServiceFormState(
          userId: authService.user!.uid,
          status: BaseStateStatus.loading,
        ),
        ServiceFormState(
          userId: authService.user!.uid,
          callbackMessage: AppLocalizations.current.unknowError,
          status: BaseStateStatus.error,
        ),
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
      'emits ServiceFormState with status success when call addService',
      build: () => cubit,
      seed: () => ServiceFormState(
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
        ServiceFormState(
          userId: authService.user!.uid,
          serviceTypes: serviceTypesMock,
          service: serviceMock,
          status: BaseStateStatus.success,
        ),
        ServiceFormState(
          userId: authService.user!.uid,
          serviceTypes: serviceTypesMock,
          quantity: quantityServices,
          service: serviceMock,
          status: BaseStateStatus.success,
        ),
        ServiceFormState(
          userId: authService.user!.uid,
          serviceTypes: serviceTypesMock,
          quantity: quantityServices,
          service: serviceMock,
          status: BaseStateStatus.loading,
        ),
        ServiceFormState(
          userId: authService.user!.uid,
          serviceTypes: serviceTypesMock,
          status: BaseStateStatus.success,
        ),
      ],
    );
  });

  group('Update Service', () {
    blocTest(
      'emits ServiceFormState with status success when call updateService',
      build: () => cubit,
      seed: () => ServiceFormState(
        userId: authService.user!.uid,
        serviceTypes: serviceTypesMock,
        status: BaseStateStatus.success,
      ),
      act: (cubit) => [
        cubit.onChangeService(serviceMock),
        cubit.updateService(),
      ],
      expect: () => [
        ServiceFormState(
          userId: authService.user!.uid,
          serviceTypes: serviceTypesMock,
          service: serviceMock,
          status: BaseStateStatus.success,
        ),
        ServiceFormState(
          userId: authService.user!.uid,
          serviceTypes: serviceTypesMock,
          service: serviceMock,
          status: BaseStateStatus.loading,
        ),
        ServiceFormState(
          userId: authService.user!.uid,
          serviceTypes: serviceTypesMock,
          status: BaseStateStatus.success,
        ),
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
      'emits ServiceFormState with new service with different date when call onChangeServiceDate',
      build: () => cubit,
      seed: () => ServiceFormState(
        userId: authService.user!.uid,
        status: BaseStateStatus.noData,
      ),
      act: (cubit) => [cubit.onChangeServiceDate(newDateTime)],
      expect: () => [
        ServiceFormState(
          userId: authService.user!.uid,
          service: Service(userId: authService.user!.uid, date: newDateTime),
          status: BaseStateStatus.noData,
        ),
      ],
    );

    blocTest(
      'emits ServiceFormState with new service with different description when call onChangeServiceDescription',
      build: () => cubit,
      seed: () => ServiceFormState(
        userId: authService.user!.uid,
        service: serviceMock,
        status: BaseStateStatus.noData,
      ),
      act: (cubit) => [cubit.onChangeServiceDescription(newDescription)],
      expect: () => [
        ServiceFormState(
          userId: authService.user!.uid,
          service: serviceMock.copyWith(description: newDescription),
          status: BaseStateStatus.noData,
        ),
      ],
    );

    blocTest(
      'emits ServiceFormState with new service with different value when call onChangeServiceValue',
      build: () => cubit,
      seed: () => ServiceFormState(
        userId: authService.user!.uid,
        service: serviceMock,
        status: BaseStateStatus.noData,
      ),
      act: (cubit) => [cubit.onChangeServiceValue(newValue)],
      expect: () => [
        ServiceFormState(
          userId: authService.user!.uid,
          service: serviceMock.copyWith(value: newValue),
          status: BaseStateStatus.noData,
        ),
      ],
    );

    blocTest(
      'emits ServiceFormState with new service with different discountPercent when call onChangeServiceDiscount',
      build: () => cubit,
      seed: () => ServiceFormState(
        userId: authService.user!.uid,
        service: serviceMock,
        status: BaseStateStatus.noData,
      ),
      act: (cubit) => [cubit.onChangeServiceDiscount(newDiscountPercent)],
      expect: () => [
        ServiceFormState(
          userId: authService.user!.uid,
          service: serviceMock.copyWith(discountPercent: newDiscountPercent),
          status: BaseStateStatus.noData,
        ),
      ],
    );

    blocTest(
      'emits ServiceFormState with new service with different discountPercent when call onChangeServiceType',
      build: () => cubit,
      seed: () => ServiceFormState(
        userId: authService.user!.uid,
        serviceTypes: serviceTypesMock..add(newServiceType),
        service: serviceMock,
        status: BaseStateStatus.noData,
      ),
      act: (cubit) => [cubit.onChangeServiceType(newDropdownItem)],
      expect: () => [
        ServiceFormState(
          userId: authService.user!.uid,
          serviceTypes: serviceTypesMock..add(newServiceType),
          service: serviceMock.copyWith(typeId: newDropdownItem.value),
          status: BaseStateStatus.noData,
        ),
      ],
    );
  });
}
