abstract class OptionStorageService {
  Future<dynamic> read(String key);
  Future<bool> save(String key, value);
  Future<bool> remove(String key);
}