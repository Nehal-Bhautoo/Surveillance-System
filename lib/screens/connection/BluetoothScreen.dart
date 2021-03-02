import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:surveillence_app/utils/widgets.dart';

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
              StreamBuilder<List<ScanResult>>(
                stream: FlutterBlue.instance.scanResults,
                initialData: [],
                builder: (c, snapshot) => Column(
                  children: snapshot.data.map((e) => ScanResultTile(
                    result: e,
                    onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) {
                      e.device.connect();
                      return DeviceScreen(device: e.device);
                    })),
                  ),
                ).toList(),
              ),
            )],
          ),
        ),
      ),
      floatingActionButton: StreamBuilder<bool>(
        stream: FlutterBlue.instance.isScanning,
        initialData: false,
        builder: (c, snapshot) {
          if (snapshot.data) {
            return FloatingActionButton(
              child: Icon(Icons.stop),
              onPressed: () => FlutterBlue.instance.stopScan(),
              backgroundColor: Colors.red,
            );
          } else {
            return FloatingActionButton(
              child: Icon(Icons.search),
              onPressed: () => FlutterBlue.instance.startScan(timeout: Duration(seconds: 4))
            );
          }
        },
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

class DeviceScreen extends StatelessWidget {
  const DeviceScreen({Key key, this.device}) : super(key: key);

  final BluetoothDevice device;

  List<int> _getRandomBytes() {
    final math = Random();
    return [
      math.nextInt(255),
      math.nextInt(255),
      math.nextInt(255),
      math.nextInt(255)
    ];
  }

  List<Widget> _buildServiceTiles(List<BluetoothService> services) {
    return services
        .map(
          (s) => ServiceTile(
        service: s,
        characteristicTiles: s.characteristics
            .map(
              (c) => CharacteristicTile(
            characteristic: c,
            onReadPressed: () => c.read(),
            onWritePressed: () async {
              await c.write(_getRandomBytes(), withoutResponse: true);
              await c.read();
            },
            onNotificationPressed: () async {
              await c.setNotifyValue(!c.isNotifying);
              await c.read();
            },
            descriptorTiles: c.descriptors
                .map(
                  (d) => DescriptorTile(
                descriptor: d,
                onReadPressed: () => d.read(),
                onWritePressed: () => d.write(_getRandomBytes()),
              ),
            )
                .toList(),
          ),
        )
            .toList(),
      ),
    )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(device.name),
        actions: <Widget>[
          StreamBuilder<BluetoothDeviceState>(
            stream: device.state,
            initialData: BluetoothDeviceState.connecting,
            builder: (c, snapshot) {
              VoidCallback onPressed;
              String text;
              switch (snapshot.data) {
                case BluetoothDeviceState.connected:
                  onPressed = () => device.disconnect();
                  text = 'DISCONNECT';
                  break;
                case BluetoothDeviceState.disconnected:
                  onPressed = () => device.connect();
                  text = 'CONNECT';
                  break;
                default:
                  onPressed = null;
                  text = snapshot.data.toString().substring(21).toUpperCase();
                  break;
              }
              return ElevatedButton(
                onPressed: onPressed,
                child: Text(text,
                  style: Theme.of(context)
                  .primaryTextTheme
                  .button
                  .copyWith(color: Colors.white),
                )
              );
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            StreamBuilder<BluetoothDeviceState>(
              stream: device.state,
              initialData: BluetoothDeviceState.connecting,
              builder: (c, snapshot) => ListTile(
                leading: (snapshot.data == BluetoothDeviceState.connected)
                    ? Icon(Icons.bluetooth_connected)
                    : Icon(Icons.bluetooth_disabled),
                title: Text(
                    'Device is ${snapshot.data.toString().split('.')[1]}.'),
                subtitle: Text('${device.id}'),
                trailing: StreamBuilder<bool>(
                  stream: device.isDiscoveringServices,
                  initialData: false,
                  builder: (c, snapshot) => IndexedStack(
                    index: snapshot.data ? 1 : 0,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.refresh),
                        onPressed: () => device.discoverServices(),
                      ),
                      IconButton(
                        icon: SizedBox(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(Colors.grey),
                          ),
                          width: 18.0,
                          height: 18.0,
                        ),
                        onPressed: null,
                      )
                    ],
                  ),
                ),
              ),
            ),
            StreamBuilder<int>(
              stream: device.mtu,
              initialData: 0,
              builder: (c, snapshot) => ListTile(
                title: Text('MTU Size'),
                subtitle: Text('${snapshot.data} bytes'),
                trailing: IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () => device.requestMtu(223),
                ),
              ),
            ),
            StreamBuilder<List<BluetoothService>>(
              stream: device.services,
              initialData: [],
              builder: (c, snapshot) {
                return Column(
                  children: _buildServiceTiles(snapshot.data),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}