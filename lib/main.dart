import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Surveillance',
      debugShowCheckedModeBanner: false,
      home: AnimatedSplashScreen(
        splash: 'images/Surveillance.svg',
        nextScreen: ,
        splashTransition: SplashTransition.rotationTransition,
        pageTransitionType: PageTransitionType.scale,
      ),
    );
  }
}