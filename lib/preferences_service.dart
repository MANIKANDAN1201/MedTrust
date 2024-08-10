// preferences_service.dart
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  static Future<void> setProfileNeedsFilling(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('profile_needs_filling', value);
  }

  static Future<bool> getProfileNeedsFilling() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('profile_needs_filling') ?? false;
  }
}
