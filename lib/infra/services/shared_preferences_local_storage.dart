import 'package:kazi/domain/services/local_storage.dart';
import 'package:kazi_core/kazi_core.dart';
import 'package:shared_preferences/shared_preferences.dart';

final class SharedPreferencesLocalStorage implements LocalStorage {
  SharedPreferencesLocalStorage(this._prefs);
  late final SharedPreferences _prefs;

  @override
  Future<void> remove(String key) => _prefs.remove(key);

  @override
  Future<void> set<T>(String key, T value) {
    switch (value) {
      case String _:
        return _prefs.setString(key, value);
      case bool _:
        return _prefs.setBool(key, value);
      case int _:
        return _prefs.setInt(key, value);
      default:
        throw ClientError(
          'No support for the data type ${T.runtimeType}',
          trace: 'Triggered in SharedPreferencesStorage',
        );
    }
  }

  @override
  T? get<T>(String key) {
    switch (T) {
      case const (String):
        return _prefs.getString(key) as T?;
      case const (bool):
        return _prefs.getBool(key) as T?;
      case const (int):
        return _prefs.getInt(key) as T?;
      case const (Object):
        return _prefs.get(key) as T?;
      default:
        throw ClientError(
          'No support for the data type ${T.runtimeType}',
          trace: 'Triggered in SharedPreferencesStorage',
        );
    }
  }
}
