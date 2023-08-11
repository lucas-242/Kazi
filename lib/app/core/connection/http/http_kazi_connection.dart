import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:kazi/app/core/connection/kazi_client.dart';
import 'package:kazi/app/core/connection/kazi_connection.dart';
import 'package:kazi/app/core/errors/errors.dart';
import 'package:kazi/app/models/api_response.dart';

class HttpKaziConnection implements KaziConnection {
  HttpKaziConnection(KaziClient client) : _client = client as http.Client;

  final http.Client _client;

  @override
  Future<ApiResponse> delete(
    String url, {
    Object? body,
    Map<String, String>? parameters,
  }) async =>
      _client
          .delete(_getUri(url, parameters), body: jsonEncode(body))
          .then((response) => _convertHttpResponse(response));

  ApiResponse _convertHttpResponse(
    http.Response response,
  ) {
    final apiResponse = ApiResponse(
      body: response.body,
      status: response.statusCode,
    );
    return apiResponse;
  }

  @override
  Future<ApiResponse> get(
    String url, {
    Map<String, String>? parameters,
  }) async =>
      _client
          .get(_getUri(url, parameters))
          .then((response) => _convertHttpResponse(response));

  Uri _getUri(String url, Map<String, String>? parameters) {
    if (url.isEmpty) {
      throw ClientError('No url informed to the current request',
          trace: 'Throwed by _getUri on KaziConnection');
    }

    if (parameters == null || parameters.isEmpty) {
      return Uri.parse(url);
    }

    return Uri.parse(url + _handleParameters(parameters));
  }

  String _handleParameters(Map<String, String> parameters) {
    var url = '?';

    for (final param in parameters.entries) {
      url += '${param.key}=${param.value}&';
    }

    //*Removes last &
    url = url.substring(0, url.length - 1);

    return url;
  }

  @override
  Future<ApiResponse> patch(
    String url, {
    Object? body,
    Map<String, String>? parameters,
  }) async =>
      _client
          .patch(_getUri(url, parameters), body: jsonEncode(body))
          .then((response) => _convertHttpResponse(response));

  @override
  Future<ApiResponse> post(
    String url, {
    Object? body,
    Map<String, String>? parameters,
  }) async =>
      _client
          .post(_getUri(url, parameters), body: jsonEncode(body))
          .then((response) => _convertHttpResponse(response));

  @override
  Future<ApiResponse> put(
    String url, {
    Object? body,
    Map<String, String>? parameters,
  }) async =>
      _client
          .put(_getUri(url, parameters), body: jsonEncode(body))
          .then((response) => _convertHttpResponse(response));

  @override
  void handleResponse(
    ApiResponse response,
  ) {
    switch (response.status) {
      //TODO: Make a retry
      case 403:
        {
          throw ClientError(response.message ?? '');
        }
      case 401:
        {
          //TODO: Refresh token
          throw ClientError(response.message ?? '');
        }
      case 400:
        {
          throw ClientError(response.message ?? '');
        }
      case 500:
        {
          throw ExternalError(response.message ?? '');
        }
    }
  }
}
