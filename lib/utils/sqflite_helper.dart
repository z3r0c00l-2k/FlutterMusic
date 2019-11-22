import 'package:flute_music_player/flute_music_player.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqfHelper {
  final libraryTable = "library";
  Database _musicDb;

  Future<void> openDb() async {
    _musicDb = await openDatabase(
      join(await getDatabasesPath(), 'libarary_db.db'),
      onCreate: (db, version) async {
        // Run the CREATE TABLE statement on the database.
        return await db.execute(
          "CREATE TABLE $libraryTable(id INTEGER PRIMARY KEY, title TEXT, artist TEXT, album TEXT, albumId INTEGER, albumArt TEXT, uri TEXT, duration INTEGER)",
        );
      },
      version: 1,
    );
  }

  Future closeDb() async {
    await _musicDb.close();
  }

  Future<void> addToLibrary(List<Song> songs) async {
    songs.forEach((song) async {
      await _musicDb.insert(
        libraryTable,
        _songToMap(song),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    });
  }

  Future<List<Song>> getMusicLibrary() async {
    final List<Map<String, dynamic>> library =
        await _musicDb.query(libraryTable);
    return List.generate(library.length, (i) {
      return Song(
        library[i]['id'],
        library[i]['artist'],
        library[i]['title'],
        library[i]['album'],
        library[i]['albumId'],
        library[i]['duration'],
        library[i]['uri'],
        library[i]['albumArt'],
      );
    });
  }

  Future<bool> musicLibraryIsEmpty() async {
    int count = Sqflite.firstIntValue(
        await _musicDb.rawQuery('SELECT COUNT(*) FROM $libraryTable'));
    if (count > 0) {
      return false;
    }
    return true;
  }

  Map<String, dynamic> _songToMap(Song song) {
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
}
