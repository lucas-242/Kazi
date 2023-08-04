import 'package:kazi/app/models/app_user.dart';
import 'package:kazi/app/models/service_type.dart';
import 'package:kazi/app/repositories/services_repository/firebase/models/firebase_service_model.dart';

final userMock = AppUser(
  uid: 'abc123',
  name: 'Jooj',
  email: 'test@test.com',
  photoUrl: 'url.com',
);

final serviceTypeMock = ServiceType(
  userId: userMock.uid,
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

final serviceMock = FirebaseServiceModel(
  date: DateTime(2022),
  type: serviceTypeMock,
  userId: userMock.uid,
  discountPercent: serviceTypeMock.discountPercent!,
  value: serviceTypeMock.defaultValue!,
  typeId: 'aaa1',
);

final servicesMock = [
  serviceMock.copyWith(date: DateTime(2022, 12)),
  serviceMock.copyWith(date: DateTime(2022, 12, 2)),
  serviceMock.copyWith(date: DateTime(2022, 12, 3)),
  serviceMock.copyWith(date: DateTime(2022, 12, 4)),
  serviceMock.copyWith(date: DateTime(2022, 12, 5)),
  serviceMock.copyWith(date: DateTime(2022, 12, 6)),
];

final serviceTypesWithIdsMock = [
  serviceTypeMock.copyWith(id: '1', name: 'test1'),
  serviceTypeMock.copyWith(id: '2', name: 'test2'),
  serviceTypeMock.copyWith(id: '3', name: 'test3'),
  serviceTypeMock.copyWith(id: '4', name: 'test4'),
  serviceTypeMock.copyWith(id: '5', name: 'test5'),
  serviceTypeMock.copyWith(id: '6', name: 'test6'),
];

final servicesWithTypeIdMock = [
  serviceMock.copyWith(typeId: '1', date: DateTime(2022, 12)),
  serviceMock.copyWith(typeId: '1', date: DateTime(2022, 12, 2)),
  serviceMock.copyWith(typeId: '2', date: DateTime(2022, 12, 3)),
  serviceMock.copyWith(typeId: '3', date: DateTime(2022, 12, 4)),
  serviceMock.copyWith(typeId: '4', date: DateTime(2022, 12, 5)),
  serviceMock.copyWith(typeId: '5', date: DateTime(2022, 12, 6)),
];

final servicesWithTypesMock = [
  serviceMock.copyWith(
    typeId: '1',
    date: DateTime(2022, 12),
    type: serviceTypeMock.copyWith(id: '1', name: 'test1'),
  ),
  serviceMock.copyWith(
    typeId: '1',
    date: DateTime(2022, 12, 2),
    type: serviceTypeMock.copyWith(id: '1', name: 'test1'),
  ),
  serviceMock.copyWith(
    typeId: '2',
    date: DateTime(2022, 12, 3),
    type: serviceTypeMock.copyWith(id: '2', name: 'test2'),
  ),
  serviceMock.copyWith(
    typeId: '3',
    date: DateTime(2022, 12, 4),
    type: serviceTypeMock.copyWith(id: '3', name: 'test3'),
  ),
  serviceMock.copyWith(
    typeId: '4',
    date: DateTime(2022, 12, 5),
    type: serviceTypeMock.copyWith(id: '4', name: 'test4'),
  ),
  serviceMock.copyWith(
    typeId: '5',
    date: DateTime(2022, 12, 6),
    type: serviceTypeMock.copyWith(id: '5', name: 'test5'),
  ),
];
