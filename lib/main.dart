import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:surveillence_app/screens/connection/ConnectionScreen.dart';
import 'package:dcdg/dcdg.dart';


void main() => runApp(MyApp());

void initState() {
  // Enter fullscreen 
  SystemChrome.setEnabledSystemUIOverlays([]);
}

void dispose() {
  // Exit full screen
  SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return MaterialApp(
      title: 'Surveillance',
      debugShowCheckedModeBanner: false,
      home: TabbedAppBar(),
    );
  }
}
