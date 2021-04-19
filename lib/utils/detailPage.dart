import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';


class DetailPage extends StatefulWidget {
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  Uint8List _data;

  Future<void> getData() async {
    try {
      BluetoothConnection connection = await BluetoothConnection.toAddress("DC:A6:32:4C:39:85");
      print('Connected to the device');
      connection.input.listen((Uint8List data) {
        print(data.runtimeType);
        setState(() {
         this._data = data;
       });
      });
    }
    catch(exception) {
      print(exception);
    }
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Connected to RaspberryPi"),
      ),
      body: SafeArea(
        child: Container(
          child: videoFrame()
        )
      ),
    );
  }

  Widget videoFrame() {
    if(_data == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return Container(
      width: 150,
      height: 150,
      decoration: BoxDecoration(
        image: new DecorationImage(
          fit: BoxFit.cover,
          image: MemoryImage(
            _data,
            scale: 0.5,
          )
        )
      ),
    );
  }
}
