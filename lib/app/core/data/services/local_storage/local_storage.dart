abstract class LocalStorage {
  Future<void> setItem({required String key, required value});
  Future<dynamic> getItem({required String key});
  Future<void> removeItem({required String key});
  Future<bool> contains({required String key});
}
