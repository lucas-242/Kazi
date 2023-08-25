import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:kazi/app/core/auth/kazi_api/models/user_data.dart';
import 'package:kazi/app/data/connection/http/http_kazi_client.dart';
import 'package:kazi/app/data/connection/kazi_client.dart';
import 'package:kazi/app/data/local_storage/local_storage.dart';
import 'package:kazi/app/models/enums/user_type.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'http_kazi_client_test.mocks.dart';

@GenerateMocks([LocalStorage])
void main() {
  late KaziClient client;
  late MockLocalStorage localStorage;
  const token = 'abc123456789';
  final user = jsonEncode(UserData(
          id: 1,
          name: 'Test',
          email: 'test@test.com',
          userType: UserType.selfEmployed,
          authExpires: DateTime.now(),
          authToken: token,
          refreshToken: 'abc12345')
      .toJson());

  setUp(() {
    localStorage = MockLocalStorage();
    client = HttpKaziClient(localStorage);
  });

  test(('Should return userAccesToken'), () {
    when(localStorage.get<String>(any)).thenAnswer((_) => user);

    expect(client.userAccessToken, isNotNull);
    expect(client.userAccessToken, token);
  });

  test(('Should Reset userAccessToken'), () {
    when(localStorage.get<String>(any)).thenAnswer((_) => null);

    client.reset();
    expect(client.userAccessToken, isNull);
  });
}
