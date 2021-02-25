import 'package:flutter/material.dart';

class BluetoothScreenLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _myListView(context);
  }
}

Widget _myListView(BuildContext context) {
  final titles = ['bike', 'boat', 'bus', 'car', 'railway', 'run', 'subway', 'transit', 'walk'];
  final colors = [
    Colors.amberAccent,
    Colors.blueAccent,
    Colors.redAccent,
    Colors.deepPurpleAccent,
    Colors.deepOrangeAccent,
    Colors.lightGreenAccent,
    Colors.blueGrey,
    Colors.pinkAccent,
    Colors.limeAccent
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
                leading: Icon(Icons.album, size: 70),
                title: Text('Heart Shaker', style: TextStyle(color: Colors.white)),
                subtitle: Text('TWICE', style: TextStyle(color: Colors.white)),
              ),
              ButtonTheme(
                child: ButtonBar(
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text('Connect', style: TextStyle(color: Colors.white)),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text('Delete', style: TextStyle(color: Colors.white)),
                    )
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