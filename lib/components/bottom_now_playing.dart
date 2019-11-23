import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_music/themes/colors.dart';

class BottomNowPlaying extends StatelessWidget {
  final String title;
  final String artist;
  final double position;
  final double duration;
  final ImageProvider albumArt;

  BottomNowPlaying(
      this.title, this.artist, this.position, this.duration, this.albumArt);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      child: Container(
        height: 98,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: <Widget>[
            Container(
              height: 98,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: DecorationImage(image: albumArt, fit: BoxFit.cover),
              ),
              child: ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                  child: Container(
                    decoration:
                        BoxDecoration(color: Colors.white.withOpacity(0.7)),
                  ),
                ),
              ),
            ),
            Row(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: 10.0, top: 10.0),
                      height: 50.0,
                      width: 50.0,
                      child: ClipRRect(
                        borderRadius: new BorderRadius.circular(6.0),
                        child: Image(image: albumArt),
                      ),
                    )
                  ],
                ),
                Container(
                  width: 250,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        title,
                        softWrap: false,
                        overflow: TextOverflow.fade,
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      Text(
                        artist,
                        softWrap: false,
                        style: TextStyle(
                            fontSize: 12.0, color: AppColors.lightTextColor),
                      ),
                      Center(
                        child: SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                            activeTrackColor: AppColors.sliderActiveColor,
                            inactiveTrackColor: AppColors.sliderInActiveColor,
                            trackHeight: 3.0,
                            thumbColor: Colors.white,
                            thumbShape:
                                RoundSliderThumbShape(enabledThumbRadius: 5.0),
                            overlayColor: Colors.purple.withAlpha(32),
                            overlayShape:
                                RoundSliderOverlayShape(overlayRadius: 10.0),
                          ),
                          child: Slider(
                            value: position ?? 0.0,
                            min: 0.0,
                            max: duration ?? 100.0,
                            onChanged: (double value) {},
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Spacer(),
                VerticalDivider(
                  width: 2,
                  endIndent: 18,
                  indent: 18,
                  color: Color(0x55ffae9a),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                        Icons.skip_previous,
                        color: AppColors.iconColor,
                      ),
                      onPressed: null,
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.skip_next,
                        color: AppColors.iconColor,
                      ),
                      onPressed: null,
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
