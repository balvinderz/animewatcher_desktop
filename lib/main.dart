import 'package:animewatcher_desktop/screens/app.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}
bool darkTheme = false;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Anime Watcher',
      debugShowCheckedModeBanner: false,
      theme: darkTheme ? ThemeData.dark(
      ) :ThemeData(
        primarySwatch: Colors.yellow,
        scaffoldBackgroundColor: Colors.white
      ),
      home: App(),
    );
  }
}
