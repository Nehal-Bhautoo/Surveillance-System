import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:surveillence_app/utils/BluetoothDeviceListEntry.dart';
import 'package:surveillence_app/utils/detailPage.dart';

class BluetoothScreenLayout extends StatefulWidget {
  @override
  _BluetoothScreenLayoutState createState() => _BluetoothScreenLayoutState();
}

class _BluetoothScreenLayoutState extends State<BluetoothScreenLayout> with WidgetsBindingObserver {
  BluetoothState _bluetoothState = BluetoothState.UNKNOWN;
  List<BluetoothDevice> devices = List<BluetoothDevice>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _getBTState();
    _stateChangeListener();
    _listBondedDevices();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if(state.index == 0) {
      // resume
      if(_bluetoothState.isEnabled) {
        _listBondedDevices();
      }
    }
  }

  _getBTState() {
    FlutterBluetoothSerial.instance.state.then((state) {
      _bluetoothState = state;
      if(_bluetoothState.isEnabled) {
        _listBondedDevices();
      }
      setState(() {});
    });
  }

  _stateChangeListener() {
    FlutterBluetoothSerial.instance
      .onStateChanged()
      .listen((BluetoothState state) {
     _bluetoothState = state;
     if(_bluetoothState.isEnabled) {
       _listBondedDevices();
     } else {
       devices.clear();
     }
     setState(() {});
    });
  }

  _listBondedDevices() {
    FlutterBluetoothSerial.instance.getBondedDevices().then((List<BluetoothDevice> bondedDevices) {
      devices = bondedDevices;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Set Up Connection"),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            SwitchListTile(
              title: Text("Enable Bluetooth"),
              value: _bluetoothState.isEnabled,
              onChanged: (bool value) {
                future() async {
                  if(value) {
                    await FlutterBluetoothSerial.instance.requestEnable();
                  } else {
                    await FlutterBluetoothSerial.instance.requestDisable();
                  }
                  future().then((_) {
                    setState(() {
                    });
                  });
                }
              },
            ),
            ListTile(
              title: Text("Bluetooth Status"),
              subtitle: Text(_bluetoothState.toString()),
              trailing: RaisedButton(
                child: Text("Settings"),
                onPressed: () {
                  FlutterBluetoothSerial.instance.openSettings();
                },
              ),
            ),
            Expanded(
              child: ListView(
                children: devices.map((_device) => BluetoothDeviceListEntry(
                  device: _device,
                  enabled: true,
                  onTap: () {
                    _startCameraConnect(context);
                  },
                )).toList(),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _startCameraConnect(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return DetailPage();
    }));
  }
}

