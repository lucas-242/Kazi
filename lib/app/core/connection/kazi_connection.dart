import 'package:kazi/app/models/api_response.dart';

abstract interface class KaziConnection {
  Future<ApiResponse> get(
    String url, {
    Map<String, String>? parameters,
  });
  Future<ApiResponse> post(
    String url, {
    Object? body,
    Map<String, String>? parameters,
  });
  Future<ApiResponse> put(
    String url, {
    Object? body,
    Map<String, String>? parameters,
  });
  Future<ApiResponse> patch(
    String url, {
    Object? body,
    Map<String, String>? parameters,
  });
  Future<ApiResponse> delete(
    String url, {
    Object? body,
    Map<String, String>? parameters,
  });

  void handleResponse(ApiResponse response);
}
