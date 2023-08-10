import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:kazi/app/core/errors/errors.dart';
import 'package:kazi/app/services/api_service/api_service.dart';
import 'package:kazi/app/services/api_service/http/http_api_service.dart';
import 'package:kazi/app/services/api_service/http/http_kazi_client.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'http_api_service_test.mocks.dart';

@GenerateMocks([HttpKaziClient])
void main() {
  late ApiService apiService;
  late MockHttpKaziClient client;
  const successStatus = 200;
  const errorStatus = 400;
  const body = '{a: "aaa"}';

  setUp(() async {
    client = MockHttpKaziClient();
    apiService = HttpApiService(client);
  });

  group('GET', () {
    test('Should return 200 in GET method', () async {
      when(client.get(any))
          .thenAnswer((_) async => http.Response(body, successStatus));

      final response = await apiService.get(
        'posts',
        parameters: {
          'param1': '1',
          'param2': '2',
        },
      );

      expect(response.body, isNotEmpty);
      expect(response.status, successStatus);
    });

    test('Should return 400 in GET method', () async {
      when(client.get(any))
          .thenAnswer((_) async => http.Response('', errorStatus));

      final response = await apiService.get('posts');
      expect(response.status, errorStatus);
    });

    test('Should throw ClientError when url is empty', () {
      expect(() => apiService.get(''), throwsA(isA<ClientError>()));
    });
  });

  group('PUT', () {
    test('Should return 200 in PUT method', () async {
      when(client.put(any, body: anyNamed('body')))
          .thenAnswer((_) async => http.Response(body, successStatus));

      final response = await apiService.put(
        'posts/1',
        body: body,
      );
      expect(response.body, isNotEmpty);
      expect(response.status, successStatus);
    });

    test('Should return 400 in PUT method', () async {
      when(client.put(any, body: anyNamed('body')))
          .thenAnswer((_) async => http.Response('', errorStatus));

      final response = await apiService.put(
        'posts/1',
        body: body,
      );
      expect(response.status, errorStatus);
    });
  });

  group('PATCH', () {
    test('Should return 200 in PATCH method', () async {
      when(client.patch(any, body: anyNamed('body')))
          .thenAnswer((_) async => http.Response(body, successStatus));

      final response = await apiService.patch(
        'posts/1',
        body: body,
      );
      expect(response.body, isNotEmpty);
      expect(response.status, successStatus);
    });

    test('Should return 400 in PATCH method', () async {
      const status = 400;
      when(client.patch(any, body: anyNamed('body')))
          .thenAnswer((_) async => http.Response('', status));

      final response = await apiService.patch(
        'posts/',
        body: body,
      );
      expect(response.status, status);
    });
  });

  group('POST', () {
    test('Should return 200 in POST method', () async {
      when(client.post(any, body: anyNamed('body')))
          .thenAnswer((_) async => http.Response(body, successStatus));

      final response = await apiService.post('posts/', body: body);
      expect(response.body, body);
      expect(response.status, successStatus);
    });

    test('Should return 400 in POST method', () async {
      when(client.post(any, body: anyNamed('body')))
          .thenAnswer((_) async => http.Response('', errorStatus));

      final response = await apiService.post(
        'posts/1',
        body: body,
      );
      expect(response.status, errorStatus);
    });
  });

  group('DELETE', () {
    test('Should return 200 in DELETE method', () async {
      when(client.delete(any, body: anyNamed('body')))
          .thenAnswer((_) async => http.Response('', successStatus));

      final response = await apiService.delete('posts/1');
      expect(response.status, successStatus);
    });

    test('Should return 400 in DELETE method', () async {
      when(client.delete(any, body: anyNamed('body')))
          .thenAnswer((_) async => http.Response('', errorStatus));

      final response = await apiService.delete('posts/1');
      expect(response.status, errorStatus);
    });
  });
}
