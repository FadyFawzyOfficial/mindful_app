import 'package:shared_preferences/shared_preferences.dart';

class SPHelper {
  static const nameKey = 'name';
  static const imageKey = 'image';

  Future<bool> setSettings({
    required String name,
    required String image,
  }) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString(nameKey, name);
      await prefs.setString(imageKey, image);
      return true;
    } on Exception catch (_) {
      return false;
    }
  }

  Future<Map<String, String>> getSettings() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String name = prefs.getString(nameKey) ?? '';
      String image = prefs.getString(imageKey) ?? '';
      return {nameKey: name, imageKey: image};
    } on Exception catch (_) {
      return {};
    }
  }
}
