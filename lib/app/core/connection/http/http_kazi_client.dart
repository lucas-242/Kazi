import 'package:http/http.dart' as http;
import 'package:kazi/app/core/connection/kazi_client.dart';
import 'package:kazi/app/core/constants/app_keys.dart';
import 'package:kazi/app/data/local_storage/local_storage.dart';

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

  String? _loadTokenFromSharedPreference() =>
      _localStorage.get<String>(AppKeys.jwtStorage);

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
