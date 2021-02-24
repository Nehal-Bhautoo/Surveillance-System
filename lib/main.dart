import 'package:flutter/material.dart';
import 'package:flare_splash_screen/flare_splash_screen.dart';
import 'package:surveillence_app/screens/home/HomeScreens.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Surveillance',
      debugShowCheckedModeBanner: false,
      home: WelcomeSplashScreen(),
    );
  }
}

class WelcomeSplashScreen extends StatefulWidget {
  @override
  _WelcomeSplashScreenState createState() => _WelcomeSplashScreenState();
}

class _WelcomeSplashScreenState extends State<WelcomeSplashScreen> {
  @override
  Widget build(BuildContext context) {
    String asset = "assets/rive/Loader.flr";
    var _size = double.infinity;
    return SplashScreen.callback(
      backgroundColor: Colors.black87,
      name: asset,
      startAnimation: "0",
      loopAnimation: 'Untitled',
      until: () => Future.delayed(Duration(seconds: 1)),
      endAnimation: '1',
      onError: (error, stacktrace) {},
      height: _size,
      onSuccess: (_) {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeScreen(title: 'Home',)));
      },
    );
  }
}