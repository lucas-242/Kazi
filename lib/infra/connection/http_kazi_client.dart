import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:kazi/core/constants/app_keys.dart';
import 'package:kazi/domain/connection/kazi_client.dart';
import 'package:kazi/domain/services/local_storage.dart';
import 'package:kazi_core/kazi_core.dart';

class HttpKaziClient extends http.BaseClient implements KaziClient {
  HttpKaziClient(this._localStorage);

  final LocalStorage _localStorage;

  String? _inMemoryToken;

  @override
  String? get userAccessToken {
    if (_inMemoryToken != null) return _inMemoryToken;

    _inMemoryToken = _loadTokenFromSharedPreference();

    return _inMemoryToken;
  }

  String? _loadTokenFromSharedPreference() {
    final stringfyUser = _localStorage.get<String>(AppKeys.userData);
    if (stringfyUser == null) {
      return null;
    }
    final response = User.fromJson(jsonDecode(stringfyUser));
    return response.authToken;
  }

  @override
  void reset() => _inMemoryToken = null;

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    request.headers['content-type'] = 'application/json';

    if (userAccessToken != null) {
      request.headers['Authorization'] = 'Bearer $userAccessToken';
    }
    return request.send();
  }
}
