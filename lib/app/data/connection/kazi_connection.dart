import 'package:kazi/app/models/api_response.dart';

abstract interface class KaziConnection {
  Future<ApiResponse> get(
    String url, {
    Map<String, dynamic>? parameters,
  });

  Future<ApiResponse> post(
    String url, {
    Object? body,
    Map<String, dynamic>? parameters,
  });

  Future<ApiResponse> put(
    String url, {
    Object? body,
    Map<String, dynamic>? parameters,
  });

  Future<ApiResponse> patch(
    String url, {
    Object? body,
    Map<String, dynamic>? parameters,
  });

  Future<ApiResponse> delete(
    String url, {
    Object? body,
    Map<String, dynamic>? parameters,
  });

  void handleResponse(ApiResponse response);
}
