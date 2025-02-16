import 'package:kazi/app/data/local_storage/local_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesStorage implements LocalStorage {

  SharedPreferencesStorage(this._prefs);
  late final SharedPreferences _prefs;

  @override
  Future<void> remove(String key) => _prefs.remove(key);

  @override
  Future<void> setBool(String key, bool value) => _prefs.setBool(key, value);

  @override
  bool? getBool(String key) => _prefs.getBool(key);
}
