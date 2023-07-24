import 'package:kazi/app/data/local_storage/local_storage.dart';
import 'package:kazi/app/models/app_user.dart';
import 'package:kazi/app/services/api_service/api_service.dart';
import 'package:kazi/app/services/auth_service/auth_service.dart';
import 'package:kazi/app/services/auth_service/kazi_api/models/auth_response.dart';
import 'package:kazi/app/shared/constants/app_keys.dart';
import 'package:kazi/app/shared/environment/environment.dart';

final class KaziApiAuthService extends AuthService {
  KaziApiAuthService(this._apiService, this._localStorage);

  final String url = '${Environment.instance.kaziApiUrl}auth';
  final ApiService _apiService;
  final LocalStorage _localStorage;

  @override
  Future<bool> signInWithGoogle() {
    throw UnimplementedError();
  }

  @override
  Future<bool> signInWithPassword() async {
    final response = await _apiService.post(url);
    _apiService.handleResponse(response);

    final authResponse = AuthResponse.fromJson(response.json);
    _saveAuthTokens(authResponse);

    return true;
  }

  void _saveAuthTokens(AuthResponse authResponse) {
    _localStorage.set(AppKeys.jwtStorage, authResponse.authenticationToken);
    _localStorage.set(AppKeys.refreshTokenStorage, authResponse.refreshToken);
  }

  @override
  Future<void> signOut() => _eraseAuthTokens();

  Future<void> _eraseAuthTokens() => Future.wait([
        _localStorage.remove(AppKeys.jwtStorage),
        _localStorage.remove(AppKeys.refreshTokenStorage),
      ]);

  @override
  Stream<AppUser?> userChanges() {
    // TODO: implement userChanges
    throw UnimplementedError();
  }
}
