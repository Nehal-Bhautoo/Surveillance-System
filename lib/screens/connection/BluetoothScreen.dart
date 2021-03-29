import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:surveillence_app/utils/led.dart';
import 'package:surveillence_app/utils/widgets.dart';

class BluetoothScreenLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Devices",
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData.dark(),
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: FutureBuilder(
        future: FlutterBluetoothSerial.instance.requestEnable(),
        builder: (context, future) {
          if(future.connectionState == ConnectionState.waiting) {
            return Scaffold(
              body: Container(
                height: double.infinity,
                child: Icon(
                  Icons.bluetooth_disabled,
                  size: 200.0,
                  color: Colors.blue,
                ),
              ),
            );
          } else if (future.connectionState == ConnectionState.done) {
            return Home();
          } else {
            return Home();
          }
        }
      ),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Connection'),
        ),
        body: SelectBondedDevicePage(
          onCahtPage: (device1) {
            BluetoothDevice device = device1;
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return ChatPage(server: device);
                },
              ),
            );
          },
        ),
      ));
  }
}