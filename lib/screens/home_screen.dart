import 'package:flutter/material.dart';
import 'package:flutter_music/components/bootom_nav_bar.dart';
import 'package:flutter_music/fragments/explore_fragment.dart';
import 'package:flutter_music/fragments/fav_fragment.dart';
import 'package:flutter_music/fragments/library_fragment.dart';
import 'package:flutter_music/fragments/search_fragment.dart';
import 'package:flutter_music/themes/colors.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _lastSelected = 0;

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
          FABBottomAppBarItem(iconData: Icons.library_music, text: 'Library'),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print("Hello");
        },
        backgroundColor: AppColors.fabColor,
        tooltip: 'Increment',
        child: Icon(Icons.pause),
        elevation: 2.0,
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
      body: Container(
        child: Column(
          children: <Widget>[
            Column(
              children: <Widget>[
                Padding(
                  padding:
                      const EdgeInsets.only(top: 45.0, left: 15.0, right: 15.0),
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
    );
  }
}
