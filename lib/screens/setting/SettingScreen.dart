import 'package:flutter/material.dart';

class SettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Setting",
      darkTheme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SettingScreenPage(),
    );
  }
}

class SettingScreenPage extends StatefulWidget {
  SettingScreenPage({Key key}) : super(key: key);
  @override
  _SettingScreenPageState createState() => _SettingScreenPageState();
}

class _SettingScreenPageState extends State<SettingScreenPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: Center(

      ),
    );
  }
}