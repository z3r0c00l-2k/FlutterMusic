import 'package:flute_music_player/flute_music_player.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqfHelper {
  static final _libraryTable = "library";
  static Database _musicDb;

  static Future<void> _openDb() async {
    _musicDb = await openDatabase(
      join(await getDatabasesPath(), 'libarary_db.db'),
      onCreate: (db, version) async {
        // Run the CREATE TABLE statement on the database.
        return await db.execute(
          "CREATE TABLE $_libraryTable(id INTEGER PRIMARY KEY, title TEXT, artist TEXT, album TEXT, albumId INTEGER, albumArt TEXT, uri TEXT, duration INTEGER)",
        );
      },
      version: 1,
    );
  }

  static Future _closeDb() async {
    await _musicDb.close();
  }

  static Future<void> addToLibrary(List<Song> songs) async {
    await _openDb();
    songs.forEach((song) async {
      await _musicDb.insert(
        _libraryTable,
        _songToMap(song),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    });
  }

  static Future<List<Song>> getMusicLibrary() async {
    await _openDb();
    final List<Map<String, dynamic>> library =
    await _musicDb.query(_libraryTable);
    _closeDb();
    return List.generate(library.length, (i) {
      return _mapToSong(library[i]);
    });
  }

  static Future<bool> musicLibraryIsEmpty() async {
    await _openDb();
    int count = Sqflite.firstIntValue(
        await _musicDb.rawQuery('SELECT COUNT(*) FROM $_libraryTable'));
    _closeDb();
    if (count > 0) {
      return false;
    }
    return true;
  }

  static Future<Song> getSongById(int id) async {
    await _openDb();
    List<Map<String, dynamic>> maps =
    await _musicDb.query(_libraryTable, where: 'id = ?', whereArgs: [id]);
    _closeDb();
    if (maps.length > 0) {
      return _mapToSong(maps.first);
    }
    return null;
  }

  static Map<String, dynamic> _songToMap(Song song) {
    return {
      'id': song.id,
      'title': song.title,
      'artist': song.artist,
      'album': song.album,
      'albumId': song.albumId,
      'albumArt': song.albumArt,
      'uri': song.uri,
      'duration': song.duration
    };
  }

  static Song _mapToSong(Map<String, dynamic> map) {
    return Song(
      map['id'],
      map['artist'],
      map['title'],
      map['album'],
      map['albumId'],
      map['duration'],
      map['uri'],
      map['albumArt'],
    );
  }
}
