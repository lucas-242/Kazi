import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:kazi/domain/connection/kazi_connection.dart';
import 'package:kazi/infra/connection/http_kazi_client.dart';
import 'package:kazi/infra/connection/http_kazi_connection.dart';
import 'package:kazi_core/kazi_core.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'http_kazi_connection_test.mocks.dart';

@GenerateMocks([HttpKaziClient])
void main() {
  late KaziConnection kaziConnection;
  late MockHttpKaziClient client;
  const successStatus = 200;
  const errorStatus = 400;
  const body = '{a: "aaa"}';

  setUp(() async {
    client = MockHttpKaziClient();
    kaziConnection = HttpKaziConnection(client);
  });

  group('GET', () {
    test('Should return 200 in GET method', () async {
      when(client.get(any))
          .thenAnswer((_) async => http.Response(body, successStatus));

      final response = await kaziConnection.get(
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

      final response = await kaziConnection.get('posts');
      expect(response.status, errorStatus);
    });

    test('Should throw ClientError when url is empty', () {
      expect(() => kaziConnection.get(''), throwsA(isA<ClientError>()));
    });
  });

  group('PUT', () {
    test('Should return 200 in PUT method', () async {
      when(client.put(any, body: anyNamed('body')))
          .thenAnswer((_) async => http.Response(body, successStatus));

      final response = await kaziConnection.put(
        'posts/1',
        body: body,
      );
      expect(response.body, isNotEmpty);
      expect(response.status, successStatus);
    });

    test('Should return 400 in PUT method', () async {
      when(client.put(any, body: anyNamed('body')))
          .thenAnswer((_) async => http.Response('', errorStatus));

      final response = await kaziConnection.put(
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

      final response = await kaziConnection.patch(
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

      final response = await kaziConnection.patch(
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

      final response = await kaziConnection.post('posts/', body: body);
      expect(response.body, body);
      expect(response.status, successStatus);
    });

    test('Should return 400 in POST method', () async {
      when(client.post(any, body: anyNamed('body')))
          .thenAnswer((_) async => http.Response('', errorStatus));

      final response = await kaziConnection.post(
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

      final response = await kaziConnection.delete('posts/1');
      expect(response.status, successStatus);
    });

    test('Should return 400 in DELETE method', () async {
      when(client.delete(any, body: anyNamed('body')))
          .thenAnswer((_) async => http.Response('', errorStatus));

      final response = await kaziConnection.delete('posts/1');
      expect(response.status, errorStatus);
    });
  });
}
