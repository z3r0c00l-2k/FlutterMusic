import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flute_music_player/flute_music_player.dart';
import 'package:flutter_music/utils/music_player.dart';

import './bloc.dart';

class MusicBloc extends Bloc<MusicEvent, MusicState> {
  MusicPlayer musicPlayer = new MusicPlayer(MusicFinder());

  @override
  MusicState get initialState => InitialMusicState();

  @override
  Stream<MusicState> mapEventToState(
    MusicEvent event,
  ) async* {
    if (event is StartPlayback) {
      // Stop current playing song and playing new one
      musicPlayer.stop();
      musicPlayer.playLocal(event.song.uri);
      yield PlayingMusicState(
          event.song, true, event.song.duration, Duration(seconds: 1));
    } else if (event is PausePlayback) {
      musicPlayer.pause();
      yield PausedMusicState(
          event.song, false, event.song.duration, event.position);
    } else if (event is ResumePlayback) {
      musicPlayer.playLocal(event.song.uri);
      yield PlayingMusicState(
          event.song, true, event.song.duration, event.position);
    } else if (event is PositionHandler) {
      yield PlayingMusicState(
          event.song, true, event.song.duration, event.position);
    } else if (event is CompletionHandler) {
      yield PlayingMusicState(event.song, true, event.song.duration,
          Duration(milliseconds: event.song.duration));
    } else if (event is LoadLastPlayed) {
      yield PausedMusicState(
          event.song, false, event.song.duration, Duration(seconds: 1));
    }
  }
}
