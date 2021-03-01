import 'package:flutter/material.dart';

class SettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Setting",
      darkTheme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SettingScreenPage extends StatefulWidget {
  @override
  _SettingScreenPageState createState() => _SettingScreenPageState();

}

class _SettingScreenPageState extends State<SettingScreenPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

    );
  }
}