import 'package:flutter/material.dart';

class FavFragment extends StatefulWidget {
  @override
  _FavFragmentState createState() => _FavFragmentState();
}

class _FavFragmentState extends State<FavFragment> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 15.0, top: 5.0),
              child: Text(
                "Favorites",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28.0),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
