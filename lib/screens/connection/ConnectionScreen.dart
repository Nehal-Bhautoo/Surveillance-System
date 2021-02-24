import 'package:flutter/material.dart';

class ConnectionScreen extends StatefulWidget {
  @override
  _ConnectionScreenState createState() => _ConnectionScreenState();
}

class _ConnectionScreenState extends State<ConnectionScreen> {
  @override
  Widget build(BuildContext context) {
    final tab = new TabBar(
      tabs: <Tab>[
        new Tab(icon: new Icon(Icons.bluetooth_connected_rounded)),
        new Tab(icon: new Icon(Icons.wifi))
      ],
    );
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: new PreferredSize(
          preferredSize: tab.preferredSize,
          child: Card(
            elevation: 10.0,
            color: Colors.blue,
            child: tab,
          ),
        ),
        body: Container(
          color: Colors.black87,
        ),
      ),
    );
  }
}