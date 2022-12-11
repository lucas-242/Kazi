import 'package:my_services/models/app_user.dart';
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
