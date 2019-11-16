import 'package:flutter/material.dart';
import 'package:flutter_music/themes/colors.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
            )
          ],
        ),
      ),
    );
  }
}
