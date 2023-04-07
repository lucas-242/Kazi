export 'shared_preferences/share_preferences_storage.dart';

abstract class LocalStorage {
  Future<void> remove(String key);
  bool? getBool(String key);
  Future<void> setBool(String key, bool value);
}
