import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:kazi/app/services/api_service/api_service.dart';
import 'package:kazi/app/services/api_service/http/http_api_service.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'http_api_service_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  // TestWidgetsFlutterBinding.ensureInitialized();
  late ApiService apiService;
  late MockClient client;

  setUp(() async {
    client = MockClient();
    apiService = HttpApiService(client);
  });

  group('GET', () {
    test('Should return 200 in GET method', () async {
      const status = 200;
      when(client.get(any))
          .thenAnswer((_) async => http.Response('{a: "aaa"}', status));

      final response = await apiService.get(
        'posts',
        parameters: {
          'param1': '1',
          'param2': '2',
        },
      );

      expect(response.body, isNotEmpty);
      expect(response.status, status);
    });

    test('Should return 400 in GET method', () async {
      const status = 400;
      when(client.get(any)).thenAnswer((_) async => http.Response('', status));

      final response = await apiService.get('posts');
      expect(response.status, status);
    });
  });

  group('PUT', () {
    test('Should return 200 in PUT method', () async {
      const status = 200;
      when(client.put(any, body: anyNamed('body')))
          .thenAnswer((_) async => http.Response('{a: "aaa"}', status));

      final response = await apiService.put(
        'posts/1',
        body: '{a: "aaa"}',
      );
      expect(response.body, isNotEmpty);
      expect(response.status, status);
    });

    test('Should return 400 in PUT method', () async {
      const status = 400;
      when(client.put(any, body: anyNamed('body')))
          .thenAnswer((_) async => http.Response('', status));

      final response = await apiService.put(
        'posts/1',
        body: '{a: "aaa"}',
      );
      expect(response.status, status);
    });
  });
}
