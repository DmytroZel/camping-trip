import 'package:injectable/injectable.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

import 'shared_preferences_module.dart';

@Injectable(as: SharedPreferencesModule)
class SharedPreferencesModuleImpl implements SharedPreferencesModule {
  final StreamingSharedPreferences sharedPreferences;
  String get idKey => "ID";
  SharedPreferencesModuleImpl({required this.sharedPreferences});

  @override
  Future<String?> getCurrentProfileId() async {
    final value =
        await sharedPreferences.getString(idKey, defaultValue: "").first;
    return value.isNotEmpty ? value : null;
  }

  @override
  Future<void> setCurrentProfileId(String? id) async {
    id == null
        ? await sharedPreferences.remove(idKey)
        : await sharedPreferences.setString(idKey, id);
  }

  @override
  Stream<String?> getCurrentProfileIdStream() {
    return sharedPreferences
        .getString(idKey, defaultValue: "")
        .map((event) => event.isNotEmpty ? event : null);
  }
}
