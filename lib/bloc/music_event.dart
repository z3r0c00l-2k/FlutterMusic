import 'package:equatable/equatable.dart';
import 'package:flute_music_player/flute_music_player.dart';

abstract class MusicEvent extends Equatable {
  const MusicEvent();
}

class StartPlayback extends MusicEvent {
  final Song song;

  StartPlayback(this.song);

  @override
  List<Object> get props => [song];
}

class ResumePlayback extends MusicEvent {
  final Song song;
  final Duration position;

  ResumePlayback(this.song, this.position);

  @override
  List<Object> get props => [song, position];
}

class PausePlayback extends MusicEvent {
  final Song song;
  final Duration position;

  PausePlayback(this.song, this.position);

  @override
  List<Object> get props => [song, position];
}

class PositionHandler extends MusicEvent {
  final Song song;
  final Duration position;

  PositionHandler(this.song, this.position);

  @override
  List<Object> get props => [song, position];
}

class CompletionHandler extends MusicEvent {
  final Song song;

  CompletionHandler(this.song);

  @override
  List<Object> get props => [song];
}
