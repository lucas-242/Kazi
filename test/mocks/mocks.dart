import 'package:kazi/app/models/user.dart';
import 'package:kazi/app/models/service.dart';
import 'package:kazi/app/models/service_type.dart';

final userMock = User.toCreate(
  id: 1,
  name: 'Jooj',
  email: 'test@test.com',
  photoUrl: 'url.com',
);

final serviceTypeMock = ServiceType.toCreate(
  userId: userMock.id,
  name: 'test',
  discountPercent: 50,
  defaultValue: 35,
);

final serviceTypesMock = [
  serviceTypeMock.copyWith(name: 'test1'),
  serviceTypeMock.copyWith(name: 'test2'),
  serviceTypeMock.copyWith(name: 'test3'),
  serviceTypeMock.copyWith(name: 'test4'),
  serviceTypeMock.copyWith(name: 'test5'),
  serviceTypeMock.copyWith(name: 'test6'),
];

final serviceMock = Service.toCreate(
  scheduledToStartAt: DateTime(2022),
  serviceType: serviceTypeMock,
  employeeId: userMock.id,
  discountPercent: serviceTypeMock.discountPercent,
  value: serviceTypeMock.defaultValue,
  serviceTypeId: 1,
);

final servicesMock = [
  serviceMock.copyWith(scheduledToStartAt: DateTime(2022, 12)),
  serviceMock.copyWith(scheduledToStartAt: DateTime(2022, 12, 2)),
  serviceMock.copyWith(scheduledToStartAt: DateTime(2022, 12, 3)),
  serviceMock.copyWith(scheduledToStartAt: DateTime(2022, 12, 4)),
  serviceMock.copyWith(scheduledToStartAt: DateTime(2022, 12, 5)),
  serviceMock.copyWith(scheduledToStartAt: DateTime(2022, 12, 6)),
];

final serviceTypesWithIdsMock = [
  serviceTypeMock.copyWith(id: 1, name: 'test1'),
  serviceTypeMock.copyWith(id: 2, name: 'test2'),
  serviceTypeMock.copyWith(id: 3, name: 'test3'),
  serviceTypeMock.copyWith(id: 4, name: 'test4'),
  serviceTypeMock.copyWith(id: 5, name: 'test5'),
  serviceTypeMock.copyWith(id: 6, name: 'test6'),
];

final servicesWithTypeIdMock = [
  serviceMock.copyWith(
      serviceTypeId: 1, scheduledToStartAt: DateTime(2022, 12)),
  serviceMock.copyWith(
      serviceTypeId: 1, scheduledToStartAt: DateTime(2022, 12, 2)),
  serviceMock.copyWith(
      serviceTypeId: 2, scheduledToStartAt: DateTime(2022, 12, 3)),
  serviceMock.copyWith(
      serviceTypeId: 3, scheduledToStartAt: DateTime(2022, 12, 4)),
  serviceMock.copyWith(
      serviceTypeId: 4, scheduledToStartAt: DateTime(2022, 12, 5)),
  serviceMock.copyWith(
      serviceTypeId: 5, scheduledToStartAt: DateTime(2022, 12, 6)),
];

final servicesWithTypesMock = [
  serviceMock.copyWith(
    serviceTypeId: 1,
    scheduledToStartAt: DateTime(2022, 12),
    serviceType: serviceTypeMock.copyWith(id: 1, name: 'test1'),
  ),
  serviceMock.copyWith(
    serviceTypeId: 1,
    scheduledToStartAt: DateTime(2022, 12, 2),
    serviceType: serviceTypeMock.copyWith(id: 1, name: 'test1'),
  ),
  serviceMock.copyWith(
    serviceTypeId: 2,
    scheduledToStartAt: DateTime(2022, 12, 3),
    serviceType: serviceTypeMock.copyWith(id: 2, name: 'test2'),
  ),
  serviceMock.copyWith(
    serviceTypeId: 3,
    scheduledToStartAt: DateTime(2022, 12, 4),
    serviceType: serviceTypeMock.copyWith(id: 3, name: 'test3'),
  ),
  serviceMock.copyWith(
    serviceTypeId: 4,
    scheduledToStartAt: DateTime(2022, 12, 5),
    serviceType: serviceTypeMock.copyWith(id: 4, name: 'test4'),
  ),
  serviceMock.copyWith(
    serviceTypeId: 5,
    scheduledToStartAt: DateTime(2022, 12, 6),
    serviceType: serviceTypeMock.copyWith(id: 5, name: 'test5'),
  ),
];
