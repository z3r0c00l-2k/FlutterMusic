import 'package:flutter/material.dart';
import 'package:flutter_music/screens/home_screen.dart';
import 'package:flutter_music/themes/app_theme.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Music',
      theme: AppTheme.buildLightTheme(),
      debugShowCheckedModeBanner: false,
      home: HomePage(title: 'Flutter Music'),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return HomeScreen();
  }
}
