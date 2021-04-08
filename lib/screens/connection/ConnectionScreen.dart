import 'package:flutter/material.dart';
import 'package:surveillence_app/screens/camera/WebViewVideo.dart';
import 'package:surveillence_app/screens/connection/BluetoothScreen.dart';

class TabbedAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData.dark(),
      theme: ThemeData.from(
        colorScheme: ColorScheme.dark(),
      ).copyWith(
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            onPrimary: Colors.blueAccent,
            primary: Colors.blue,
          )
        ),
      ),
      home: DefaultTabController(
        length: choices.length,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Choose a connection'),
            bottom: TabBar(
              isScrollable: true,
              tabs: choices.map<Widget>((Choice choice) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 35.0),
                      child: Tab(
                        text: choice.title,
                        icon: Icon(choice.icon),
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              BluetoothScreenLayout(),
              WebViewPage()
            ]
          ),
        ),
      ),
    );
  }
}

class Choice {
  final int id;
  final String title;
  final IconData icon;
  const Choice({this.id, this.title, this.icon});
}

const List<Choice> choices = <Choice>[
  Choice(id: 1, title: 'Bluetooth', icon: Icons.bluetooth_connected_rounded),
  Choice(id: 2, title: 'Wi-Fi', icon: Icons.wifi)
];

class ConnectionScreen extends StatelessWidget {
  final Choice choice;
  const ConnectionScreen({Key key, this.choice}) : super(key : key);
  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = Theme.of(context).textTheme.headline2;
    return Card(
      color: Color(0xFF242426),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
          Icon(
            choice.icon,
            size: 150.0,
            color: textStyle.color,
          ),
          Text(
            choice.title,
            style: textStyle,
          )],
        ),
      ),
    );
  }
}
