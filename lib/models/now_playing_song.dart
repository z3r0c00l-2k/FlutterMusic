import 'package:equatable/equatable.dart';
import 'package:flute_music_player/flute_music_player.dart';

class NowPlayingSong extends Equatable {
  final Song song;
  final bool isPlaying;
  final Duration position;

  NowPlayingSong(this.song, this.isPlaying, this.position);

  @override
  List<Object> get props => [song, isPlaying, position];
}
