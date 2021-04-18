import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class DetailPage extends StatefulWidget {
  final BluetoothDevice server;
  const DetailPage({this.server});
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  BluetoothConnection connection;
  bool isConnecting = true;
  bool get isConnected => connection != null && connection.isConnected;
  bool isDisconnecting = false;

  List<List<int>> chunks = <List<int>>[];
  int contentLength = 0;
  Uint8List _bytes;

  @override
  void initState() {
    super.initState();
    _getBTConnection();
  }

  @override
  void dispose() {
    if(isConnected) {
      isDisconnecting = true;
      connection.dispose();
      connection = null;
    }
    super.dispose();
  }

  _getBTConnection() {
    BluetoothConnection.toAddress(widget.server.address).then((_connection) {
      connection = _connection;
      isConnecting = false;
      isDisconnecting = false;
      setState(() {});
      connection.input.listen(_onDataReceived).onDone(() {
        if(isDisconnecting) {
          print('Disconnecting locally');
        } else {
          print("Disconnecting remotely");
        }
        if(this.mounted) {
          setState(() {

          });
        }
        Navigator.of(context).pop();
      });
    }).catchError((error) {
      Navigator.of(context).pop();
    });
  }

  void _onDataReceived(Uint8List data) {
    if(data != null && data.length > 0) {
      chunks.add(data);
      contentLength += data.length;
    }
    print("Data Length: ${data.length}, chunks: ${chunks.length}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: (isConnecting
          ? Text('Connecting to ${widget.server.name} ...')
          : isConnected
            ? Text('Connected to ${widget.server.name}')
            : Text('Connected to ${widget.server.name}')
        ),
      ),
      body: SafeArea(
        child: isConnected
          ? Column(
            children: <Widget>[
            ],
        ) : Center(
          child: Text(
            "Connecting...",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white
            ),
          ),
        )
      ),
    );
  }

  // Widget videoFrame() {
  //   return Expanded(
  //     child: Container(
  //       width: double.infinity,
  //       child: _bytes != null
  //         ? ,
  //     ),
  //   );
  // }
}
