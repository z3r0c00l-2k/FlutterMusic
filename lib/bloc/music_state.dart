import 'package:equatable/equatable.dart';
import 'package:flute_music_player/flute_music_player.dart';

abstract class MusicState extends Equatable {
  const MusicState();
}

class InitialMusicState extends MusicState {
  const InitialMusicState();

  @override
  List<Object> get props => [];
}

class PlayingMusicState extends MusicState {
  final Song song;
  final isPlaying;
  final int duration;
  final Duration position;

  const PlayingMusicState(
      this.song, this.isPlaying, this.duration, this.position);

  @override
  List<Object> get props => [song, isPlaying, duration, position];
}

class PausedMusicState extends MusicState {
  final Song song;
  final bool isPlaying;
  final int duration;
  final Duration position;

  const PausedMusicState(
      this.song, this.isPlaying, this.duration, this.position);

  @override
  List<Object> get props => [isPlaying, song, duration, position];
}
