import 'package:flute_music_player/flute_music_player.dart';
import 'package:flutter/material.dart';

class LibraryFragment extends StatefulWidget {
  @override
  _LibraryFragmentState createState() => _LibraryFragmentState();
}

class _LibraryFragmentState extends State<LibraryFragment> {
  List<Song> _songs = List();

  @override
  void initState() {
    super.initState();
    initMusicList();
  }

  void initMusicList() async {
    List<Song> songs = await MusicFinder.allSongs();
    setState(() {
      _songs = songs;
    });
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
          child: ListView.builder(
              itemCount: _songs.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Row(
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            _songs[index].title,
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          Text(
                            _songs[index].artist,
                            style: TextStyle(fontSize: 12.0),
                          ),
                          Text(
                            _songs[index].duration.toString(),
                            style: TextStyle(fontSize: 12.0),
                          )
                        ],
                      )
                    ],
                  ),
                );
              }),
        )
      ],
    );
  }
}
