import 'package:http/http.dart' as http;
import 'package:kazi/app/data/local_storage/local_storage.dart';
import 'package:kazi/app/models/api_response.dart';
import 'package:kazi/app/services/api_service/api_service.dart';
import 'package:kazi/app/shared/constants/app_keys.dart';
import 'package:kazi/app/shared/errors/errors.dart';

final class HttpApiService implements ApiService {
  HttpApiService(this._localStorage);

  final LocalStorage _localStorage;

  String? get jwtToken => _localStorage.get<String>(AppKeys.jwtStorage);

  String? get refreshToken =>
      _localStorage.get<String>(AppKeys.refreshTokenStorage);

  Map<String, String> get _headers {
    final t = jwtToken;
    final Map<String, String> response = {
      'content-type': 'application/json; charset=utf-8',
    };

    if (t != null) {
      response.putIfAbsent('Authorization', () => 'Bearer $t');
    }

    return response;
  }

  @override
  Future<ApiResponse> delete(
    String url, {
    Object? body,
    Map<String, String>? parameters,
  }) async =>
      http
          .delete(_getUri(url, parameters), body: body, headers: _headers)
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
          .get(_getUri(url, parameters), headers: _headers)
          .then((response) => _convertHttpResponse(response));

  Uri _getUri(String url, Map<String, String>? parameters) {
    if (url.isEmpty) {
      throw ClientError('No url informed to the current request',
          trace: 'Throwed by _getUri on HttpApiService');
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
      http
          .patch(_getUri(url, parameters), body: body, headers: _headers)
          .then((response) => _convertHttpResponse(response));

  @override
  Future<ApiResponse> post(
    String url, {
    Object? body,
    Map<String, String>? parameters,
  }) async =>
      http
          .post(_getUri(url, parameters), body: body, headers: _headers)
          .then((response) => _convertHttpResponse(response));

  @override
  Future<ApiResponse> put(
    String url, {
    Object? body,
    Map<String, String>? parameters,
  }) async =>
      http
          .put(_getUri(url, parameters), body: body, headers: _headers)
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
