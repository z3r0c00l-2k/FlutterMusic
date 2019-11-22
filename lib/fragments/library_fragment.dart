import 'dart:async';
import 'dart:io';

import 'package:flute_music_player/flute_music_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_music/bloc/music_bloc.dart';
import 'package:flutter_music/bloc/music_event.dart';
import 'package:flutter_music/themes/colors.dart';

class LibraryFragment extends StatefulWidget {
  @override
  _LibraryFragmentState createState() => _LibraryFragmentState();
}

class _LibraryFragmentState extends State<LibraryFragment> {
  Future<List<Song>> _getMusicList() async {
    List<Song> songs = await MusicFinder.allSongs();
    return songs;
  }

  Future _playLocal(Song song) async {
    final musicBloc = BlocProvider.of<MusicBloc>(context);
    musicBloc.add(StartPlayback(song));
    musicBloc.musicPlayer.audioPlayer.setPositionHandler(
            (Duration position) =>
            musicBloc.add(PositionHandler(song, position)));
    musicBloc.musicPlayer.audioPlayer
        .setCompletionHandler(() => musicBloc.add(CompletionHandler(song)));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 15.0, top: 5.0),
              child: Text(
                "Library",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28.0),
              ),
            ),
          ],
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height - 180,
          child: FutureBuilder(
            future: _getMusicList(),
            builder:
                // ignore: missing_return
                (BuildContext context, AsyncSnapshot<List<Song>> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return Text('Press button to start.');
                case ConnectionState.active:
                case ConnectionState.waiting:
                  return Text('Loading..');
                case ConnectionState.done:
                  if (snapshot.hasError)
                    return Text('Error: ${snapshot.error}');
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          Widget albumArt;
                          try {
                            albumArt = CircleAvatar(
                                radius: 30.0,
                                backgroundImage: FileImage(
                                    File(snapshot.data[index].albumArt)));
                          } catch (e) {
                            albumArt = CircleAvatar(
                                radius: 30.0,
                                child: Text(snapshot.data[index].title[0]
                                    .toUpperCase()));
                          }

                          return InkWell(
                            onTap: () => _playLocal(snapshot.data[index]),
                            child: Row(
                              children: <Widget>[
                                Flexible(
                                  child: Container(
                                    margin: EdgeInsets.only(bottom: 25.0),
                                    child: Row(
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 15.0),
                                          child: albumArt,
                                        ),
                                        Flexible(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                snapshot.data[index].title,
                                                softWrap: false,
                                                overflow: TextOverflow.fade,
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              Text(
                                                snapshot.data[index].artist,
                                                style: TextStyle(
                                                    fontSize: 12.0,
                                                    color: AppColors
                                                        .lightTextColor),
                                              ),
                                              Text(
                                                _formatDuration(snapshot
                                                    .data[index].duration),
                                                style:
                                                    TextStyle(fontSize: 12.0),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                  );
              }
            },
          ),
        )
      ],
    );
  }

  String _formatDuration(int dur) {
    Duration duration = Duration(milliseconds: dur);
    String twoDigits(int n) {
      if (n >= 10) return "$n";
      return "0$n";
    }

    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    if (duration.inHours < 0)
      return "${duration.inHours}:$twoDigitMinutes:$twoDigitSeconds";
    else
      return "$twoDigitMinutes:$twoDigitSeconds";
  }
}
