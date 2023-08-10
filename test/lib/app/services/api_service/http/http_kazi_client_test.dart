import 'package:flutter_test/flutter_test.dart';
import 'package:kazi/app/data/local_storage/local_storage.dart';
import 'package:kazi/app/services/api_service/http/http_kazi_client.dart';
import 'package:kazi/app/services/api_service/kazi_client.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'http_kazi_client.test.mocks.dart';

@GenerateMocks([LocalStorage])
void main() {
  late KaziClient client;
  late MockLocalStorage localStorage;
  const token = 'abcd123';

  setUpAll(() async {
    localStorage = MockLocalStorage();
    client = HttpKaziClient(localStorage);
  });

  test(('Should return userAccesToken'), () {
    when(localStorage.get<String>(any)).thenAnswer((_) => token);

    expect(client.userAccessToken, isNotNull);
    expect(client.userAccessToken, token);
  });

  test(('Should Reset userAccessToken'), () {
    when(localStorage.get<String>(any)).thenAnswer((_) => null);

    client.reset();
    expect(client.userAccessToken, isNull);
  });
}
