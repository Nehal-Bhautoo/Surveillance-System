import 'package:flutter/material.dart';

class TabbedAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData.dark(),
      home: DefaultTabController(
        length: choice.length,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Choose a connectivity'),
            bottom: TabBar(
              isScrollable: true,
              tabs: choice.map<Widget>((Choice choice) {
                return Tab(
                  text: choice.title,
                  icon: Icon(choice.icon),
                );
              }).toList(),
            ),
          ),
          body: TabBarView(
            children: choice.map((Choice choice) {
              return Padding(
                padding: const EdgeInsets.all(5.0),
                child: ConnectionScreen(choice: choice),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

class Choice {
  final String title;
  final IconData icon;
  const Choice({this.title, this.icon});
}

const List<Choice> choice = <Choice>[
  Choice(title: 'Bluetooth', icon: Icons.bluetooth_connected_rounded),
  Choice(title: 'Wi-Fi', icon: Icons.wifi)
];

class ConnectionScreen extends StatelessWidget {
  final Choice choice;
  const ConnectionScreen({Key key, this.choice}) : super(key : key);
  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = Theme.of(context).textTheme.display1;
    return Card(
      color: Colors.white,
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