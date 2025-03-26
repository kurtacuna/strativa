import 'package:get_storage/get_storage.dart';

class Storage {
  Future<void> clear() {
    return GetStorage().erase();
  }

  Future<void> setString(String key, String value) {
      return GetStorage().write(key, value);
  }

  String? getString(String key) {
    return GetStorage().read(key);
  }

  // Future<void> setBool(String key, bool value) {
  //   return GetStorage().write(key, value);
  // }

  // bool? getBool(String key) {
  //   return GetStorage().read(key);
  // }

  Future<void> removeKey(String key) {
    return GetStorage().remove(key);
  }
}