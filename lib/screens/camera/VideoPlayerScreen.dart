import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';


class VideoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Camera",
      darkTheme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: VideoScreenPage(),
    );
  }
}

class VideoScreenPage extends StatefulWidget {
  VideoScreenPage({Key key}) : super(key: key);

  @override
  _VideoScreenPageState createState() => _VideoScreenPageState();
}

class _VideoScreenPageState extends State<VideoScreenPage> {
  VlcPlayerController _vlcPlayerController;
  Future<void> initializePlayer() async {}
  @override
  void initState() {
    super.initState();

    _vlcPlayerController = VlcPlayerController.network(
      'https://media.w3.org/2010/05/sintel/trailer.mp4',
      hwAcc: HwAcc.FULL,
      autoPlay: false,
      options: VlcPlayerOptions(),
    );
  }

  @override
  void dispose() async {
    super.dispose();
    await _vlcPlayerController.stopRendererScanning();
    await _vlcPlayerController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: VlcPlayer(
          controller: _vlcPlayerController,
          aspectRatio: 16 / 9,
          placeholder: Center(child: CircularProgressIndicator(),),
        ),
      ),
    );
  }
}