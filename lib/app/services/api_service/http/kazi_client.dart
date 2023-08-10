import 'package:http/http.dart' as http;
import 'package:kazi/app/core/constants/app_keys.dart';
import 'package:kazi/app/data/local_storage/local_storage.dart';

class KaziClient extends http.BaseClient {
  KaziClient(this._localStorage);

  final LocalStorage _localStorage;
  final _client = http.Client();

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    request.headers['content-type'] = 'application/json';

    final authToken = _localStorage.get<String>(AppKeys.jwtStorage);
    if (authToken != null) {
      request.headers['Authorization'] = 'Bearer $authToken';
    }
    return _client.send(request);
  }
}
