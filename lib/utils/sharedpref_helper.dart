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
    int id = _prefs.getInt('nowPlaying') ?? -1;
    int position = _prefs.getInt('position') ?? -1;
    Map<String, int> map = Map();
    map['id'] = id;
    map['position'] = position;
    return map;
  }

  static Future<void> addCurrentPosition(Duration position) async {
    await _loadPref();
    await _prefs.setInt('position', position.inMilliseconds);
  }
}
