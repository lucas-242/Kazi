import 'dart:convert';
import 'dart:js_interop';

import 'package:http/http.dart' as http;
import 'package:kazi/app/models/api_response.dart';
import 'package:kazi/app/services/api_service/api_service.dart';
import 'package:kazi/app/shared/errors/errors.dart';
import 'package:shared_preferences/shared_preferences.dart';

final class HttpApiService implements ApiService {
  HttpApiService(this.url);

  final String url;

  Future<String?> get token async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return null;
    }

    final extractedUserData =
        json.decode(prefs.getString('userData')!) as Map<String, Object>;
    return extractedUserData['token'] as String;
  }

  Future<Map<String, String>> get _headers async {
    final t = await token;
    if (t == null) {
      return {
        'content-type': 'application/json; charset=utf-8',
      };
    }

    return {
      'content-type': 'application/json; charset=utf-8',
      'Authorization': 'Bearer $t'
    };
  }

  @override
  Future<ApiResponse> delete(
    String url, {
    Object? body,
    Map<String, String>? parameters,
  }) async =>
      http
          .delete(_getUri(url, parameters), body: body, headers: await _headers)
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
      http
          .get(_getUri(url, parameters), headers: await _headers)
          .then((response) => _convertHttpResponse(response));

  Uri _getUri(String url, Map<String, String>? parameters) {
    if (url.isEmpty) {
      throw ClientError('No url informed to the current request',
          trace: 'Throwed by _getUri on HttpApiService');
    }

    if (parameters.isNull || parameters!.isEmpty) {
      Uri.parse(url);
    }

    return Uri.parse(url + _handleParameters(parameters!));
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
      http
          .patch(_getUri(url, parameters), body: body, headers: await _headers)
          .then((response) => _convertHttpResponse(response));

  @override
  Future<ApiResponse> post(
    String url, {
    Object? body,
    Map<String, String>? parameters,
  }) async =>
      http
          .post(_getUri(url, parameters), body: body, headers: await _headers)
          .then((response) => _convertHttpResponse(response));

  @override
  Future<ApiResponse> put(
    String url, {
    Object? body,
    Map<String, String>? parameters,
  }) async =>
      http
          .put(_getUri(url, parameters), body: body, headers: await _headers)
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
