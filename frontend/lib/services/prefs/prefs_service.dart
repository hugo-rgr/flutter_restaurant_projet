import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final prefsProvider = Provider.autoDispose(PreferencesService.new);

class PreferencesService {
  PreferencesService(this.ref);

  Ref ref;

  final instance = const FlutterSecureStorage();



  Future<void> removeKey(String key) async {
    if (await containsKey(key)) {
      await instance.delete(key: key);
    }
  }

  Future<bool> containsKey(String key) async {
    return instance.containsKey(key: key);
  }

  Future<String?> getString(String key) async {
    return instance.read(key: key);
  }

  Future<void> setString(String key, String? value) async {
    return instance.write(key: key, value: value);
  }

  Future<int?> getInt(String key) async {
    final value = await getString(key);
    if (value != null) {
      return int.tryParse(value);
    }
    return null;
  }

  Future<void> setInt(String key, int value) async {
    return setString(key, value.toString());
  }

  Future<bool?> getBool(String key) async {
    final value = await getString(key);
    if (value != null) {
      return bool.tryParse(value);
    }
    return null;
  }

  Future<void> setBool(String key, {required bool value}) async {
    return setString(key, value.toString());
  }
}

class PersistStoreKey {
  static const String token = 'token';
  static const String email = 'email';
  static const String password = 'password';
}
