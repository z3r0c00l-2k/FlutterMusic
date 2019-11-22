import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefHelper {
  static SharedPreferences _prefs;

  static Future<void> _loadPref() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<void> addNowPlaying(int id) async {
    await _loadPref();
    await _prefs.setInt('nowPlaying', id);
  }

  static Future<Map<String, int>> getLastPlayed() async {
    await _loadPref();
    return {
      "id": (_prefs.getInt('nowPlaying') ?? null),
      "position": (_prefs.getInt('position' ?? null))
    };
  }

  static Future<void> addCurrentPosition(Duration position) async {
    await _loadPref();
    await _prefs.setInt('position', position.inMilliseconds);
  }
}
