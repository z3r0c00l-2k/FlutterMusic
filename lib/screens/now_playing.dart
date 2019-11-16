import 'package:flutter/material.dart';
import 'package:flutter_music/themes/colors.dart';

class NowPlaying extends StatefulWidget {
  @override
  _NowPlayingState createState() => _NowPlayingState();
}

class _NowPlayingState extends State<NowPlaying> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding:
                  const EdgeInsets.only(top: 45.0, left: 15.0, right: 15.0),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: Icon(
                      Icons.keyboard_arrow_down,
                      color: AppColors.iconColor,
                    ),
                  ),
                  Text(
                    "Flutter Music",
                    style: TextStyle(
                        fontSize: 20.0,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w500),
                  ),
                  Spacer(),
                  Icon(
                    Icons.settings,
                    color: AppColors.iconColor,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
