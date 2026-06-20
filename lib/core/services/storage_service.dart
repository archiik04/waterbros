class StorageService {
  // A mock storage service that will be replaced with Shared Preferences or secure storage later.
  final Map<String, String> _storage = {};

  Future<void> write(String key, String value) async {
    _storage[key] = value;
  }

  Future<String?> read(String key) async {
    return _storage[key];
  }

  Future<void> delete(String key) async {
    _storage.remove(key);
  }

  Future<void> clear() async {
    _storage.clear();
  }
}
