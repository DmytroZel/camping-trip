
abstract class SharedPreferencesModule {
  Future<String?> getCurrentProfileId();
  Future<void> setCurrentProfileId(String? id);
  Stream<String?> getCurrentProfileIdStream();
}