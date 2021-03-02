import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

class BluetoothScreenLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StreamBuilder<BluetoothState>(
        stream: FlutterBlue.instance.state,
        initialData: BluetoothState.unknown,
        builder: (c, snapshot) {
          final state = snapshot.data;
          if(state == BluetoothState.on) {
            return _myListView(context);
          } return BluetoothOffScreen(state: state);
        },
      ),
    );
  }
}

class BluetoothOffScreen extends StatelessWidget {
  const BluetoothOffScreen({Key key, this.state}) : super(key: key);
  final BluetoothState state;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 8.0,
        top: 8.0,
        right: 8.0,
        bottom: 30.0
      ),
      child: Card(
        shadowColor: Colors.black87,
        color: Colors.blueAccent,
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(
                Icons.bluetooth_disabled,
                size: 200.0,
                color: Colors.white54,
              ),
              Text(
                'Bluetooth Adapter is ${state != null ? state.toString().substring(15) : 'not available'}.',
                style: Theme.of(context)
                .primaryTextTheme
                .subtitle1
                .copyWith(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FindDevicesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Find Devices'),
      ),
      body: RefreshIndicator(
        onRefresh: () => FlutterBlue.instance.startScan(timeout: Duration(seconds: 5)),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              StreamBuilder<List<BluetoothDevice>>(
                stream: Stream.periodic(Duration(seconds: 2)).asyncMap((event) => FlutterBlue.instance.connectedDevices),
                initialData: [],
                builder: (c, snapshot) => Column(
                  children: snapshot.data.map((e) => ListTile(
                    title: Text(e.name),
                    subtitle: Text(e.id.toString()),
                    trailing: StreamBuilder<BluetoothDeviceState>(
                      stream: e.state,
                      initialData: BluetoothDeviceState.disconnected,
                      builder: (c, snapshot) {
                        if(snapshot.data == BluetoothDeviceState.connected) {
                          return ElevatedButton(
                            child: Text('OPEN'),
                            onPressed: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => DeviceScreen(device: e))),
                          );
                        }
                        return Text(snapshot.data.toString());
                      },
                    ),
                  )).toList(),
                ),
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}

Widget _myListView(BuildContext context) {
  final titles = ['Nehal', 'Bhautoo', 'Middlesex'];
  final colors = [
    Colors.amber,
    Colors.cyan,
    Colors.deepPurple,
    Colors.deepOrange,
    Colors.lightGreen,
    Colors.red,
    Colors.teal,
    Colors.pink,
    Colors.lime
  ];

  return ListView.builder(
    itemCount: titles.length,
    itemBuilder: (context, index) {
      return Padding(
        padding: const EdgeInsets.only(
          left: 8.0,
          top: 5.0,
          right: 8.0,
          bottom: 0.0
        ),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          color: colors[index],
          elevation: 10,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const ListTile(
                leading: Icon(Icons.devices_other_rounded, size: 70, color: Colors.white70,),
                title: Text("Device Name", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                subtitle: Text('Device ID', style: TextStyle(color: Colors.white)),
              ),
              ButtonTheme(
                child: ButtonBar(
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text('Connect', style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
    },
  );
}