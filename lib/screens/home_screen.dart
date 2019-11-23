import 'package:flute_music_player/flute_music_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_music/bloc/bloc.dart';
import 'package:flutter_music/components/bootom_nav_bar.dart';
import 'package:flutter_music/fragments/explore_fragment.dart';
import 'package:flutter_music/fragments/fav_fragment.dart';
import 'package:flutter_music/fragments/library_fragment.dart';
import 'package:flutter_music/fragments/search_fragment.dart';
import 'package:flutter_music/themes/colors.dart';
import 'package:flutter_music/utils/sharedpref_helper.dart';
import 'package:flutter_music/utils/sqflite_helper.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _lastSelected = 0;

  // Initializing Bloc
  final MusicBloc musicBloc = MusicBloc();

  @override
  void initState() {
    super.initState();
    _getLastPlayed();
  }

  void _getLastPlayed() async {
    Map<String, int> lastPlayed = await SharedPrefHelper.getLastPlayed();
    // On first try we're getting null, that's why i ran this code two times
    if (lastPlayed != null) {
      if (lastPlayed['nowPlaying'] < 0) {
        Song lastPlayedSong =
        await SqfHelper.getSongById(lastPlayed['nowPlaying']);
        musicBloc.add(LoadLastPlayed(lastPlayedSong));
      }
    } else {
      lastPlayed = await SharedPrefHelper.getLastPlayed();
      if (lastPlayed['nowPlaying'] < 0) {
        Song lastPlayedSong =
        await SqfHelper.getSongById(lastPlayed['nowPlaying']);
        musicBloc.add(LoadLastPlayed(lastPlayedSong));
      }
    }
  }

  void _selectedTab(int index) {
    setState(() {
      _lastSelected = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget currentFragement;
    switch (_lastSelected) {
      case 0:
        currentFragement = new SearchFragment();
        break;
      case 1:
        currentFragement = new FavFragment();
        break;
      case 2:
        currentFragement = new ExploreFragment();
        break;
      case 3:
        currentFragement = new LibraryFragment();
        break;
    }

    return BlocBuilder(
      bloc: musicBloc,
      builder: (context, MusicState state) {
        return Scaffold(
          bottomNavigationBar: FABBottomAppBar(
            color: AppColors.iconColorUnselected,
            selectedColor: AppColors.iconColor,
            notchedShape: CircularNotchedRectangle(),
            onTabSelected: _selectedTab,
            items: [
              FABBottomAppBarItem(iconData: Icons.search, text: 'Search'),
              FABBottomAppBarItem(iconData: Icons.favorite, text: 'Favorites'),
              FABBottomAppBarItem(iconData: Icons.explore, text: 'Explore'),
              FABBottomAppBarItem(
                  iconData: Icons.library_music, text: 'Library'),
            ],
          ),
          floatingActionButtonLocation:
          FloatingActionButtonLocation.centerDocked,
          floatingActionButton: _buildFab(state),
          body: BlocProvider.value(
            value: musicBloc,
            child: Container(
              child: Column(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 45.0, left: 15.0, right: 15.0),
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(right: 20.0),
                              child: Image.asset(
                                "images/logo.png",
                                height: 25.0,
                              ),
                            ),
                            Text(
                              "Flutter Music",
                              style: TextStyle(
                                  fontSize: 18.0,
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.bold),
                            ),
                            Spacer(),
                            Icon(
                              Icons.shuffle,
                              color: AppColors.iconColor,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    child: currentFragement,
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildFab(MusicState state) {
    var tooltip = "Play";
    var icon = Icon(Icons.play_arrow);
    if (state is PlayingMusicState) {
      if (state.duration == state.position.inMilliseconds) {
        tooltip = "Play";
        icon = Icon(Icons.play_arrow);
      } else {
        tooltip = "Pause";
        icon = Icon(Icons.pause);
      }
    }
    return FloatingActionButton(
      onPressed: () {
        if (state is PlayingMusicState) {
          musicBloc.add(PausePlayback(state.song, state.position));
          print("Position is ${state.position}");
        } else if (state is PausedMusicState) {
          musicBloc.add(ResumePlayback(state.song, state.position));
        }
      },
      backgroundColor: AppColors.fabColor,
      tooltip: tooltip,
      child: icon,
      elevation: 2.0,
    );
  }

  @override
  void dispose() {
    super.dispose();
    musicBloc.close();
  }
}
