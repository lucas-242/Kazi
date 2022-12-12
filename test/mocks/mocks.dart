import 'package:my_services/models/app_user.dart';
import 'package:my_services/models/service_type.dart';
import 'package:my_services/repositories/services_repository/firebase/models/firebase_service_model.dart';

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
