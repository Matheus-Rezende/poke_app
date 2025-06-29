import 'package:poke_app/app/core/data/services/local_storage/local_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageSharedImpl extends LocalStorage {
  //LocalStorageImpl({required this.storage});
  @override
  Future<bool> contains({required String key}) async {
    try {
      SharedPreferences sharedPref = await SharedPreferences.getInstance();
      return sharedPref.containsKey(key);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> setItem({required String key, required value}) async {
    try {
      SharedPreferences sharedPref = await SharedPreferences.getInstance();
      switch (value.runtimeType) {
        case const (String):
          return sharedPref.setString(key, value);
        case const (bool):
          return sharedPref.setBool(key, value);
        case const (double):
          return sharedPref.setDouble(key, value);
        case const (int):
          return sharedPref.setInt(key, value);
        case const (List<String>):
          return sharedPref.setStringList(key, value);
        default:
          throw ('Tipo invalido!');
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> getItem({required String key}) async {
    try {
      SharedPreferences sharedPref = await SharedPreferences.getInstance();

      return sharedPref.get(key);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> removeItem({required String key}) async {
    try {
      SharedPreferences sharedPref = await SharedPreferences.getInstance();
      return await sharedPref.remove(key);
    } catch (e) {
      rethrow;
    }
  }
}
