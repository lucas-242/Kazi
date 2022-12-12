import 'package:my_services/models/app_user.dart';
import 'package:my_services/models/service.dart';
import 'package:my_services/models/service_type.dart';

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

final serviceMock = Service(
  date: DateTime(2022),
  type: serviceTypeMock,
  userId: userMock.uid,
  discountPercent: serviceTypeMock.discountPercent!,
  value: serviceTypeMock.defaultValue!,
  typeId: 'aaa1',
);
