import 'package:flute_music_player/flute_music_player.dart';

class MusicPlayer {
  MusicFinder audioPlayer;

  MusicPlayer(this.audioPlayer);

  Future playLocal(String uri) async {
    final result = await audioPlayer.play(uri, isLocal: true);
    if (result == 1) {
      return true;
    }
    return false;
  }

  Future pause() async {
    final result = await audioPlayer.pause();
    if (result == 1) {
      return true;
    }
    return false;
  }

  Future stop() async {
    final result = await audioPlayer.stop();
    if (result == 1) {
      return true;
    }
    return false;
  }
}
