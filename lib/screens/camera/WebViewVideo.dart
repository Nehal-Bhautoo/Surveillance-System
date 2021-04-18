import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:webview_flutter/platform_interface.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

final webViewKey = GlobalKey<WebViewScreenState>();
Color appBarColor = Colors.blue;
String appBarTitle = "Live Video Feed";

class WebViewPage extends StatefulWidget {
  @override
  WebViewPageState createState() => WebViewPageState();
}

class WebViewPageState extends State<WebViewPage> with SingleTickerProviderStateMixin {
  bool isOpened = false;
  AnimationController _animationController;
  Animation<Color> _animateColor;
  Animation<double> _animateIcon;
  Curve _curve = Curves.easeOut;

  @override
  initState() {
    _animationController =
      AnimationController(vsync: this, duration: Duration(milliseconds: 500))
        ..addListener(() {
        setState(() {});
      });
    _animateIcon = Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    _animateColor = ColorTween(
      begin: Colors.blue,
      end: Colors.red,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.00,
        1.00,
        curve: _curve,
      ),
    ));
    super.initState();
  }

  @override
  dispose() {
    _animationController.dispose();
    super.dispose();
  }

  animate() {
    if (!isOpened) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
    isOpened = !isOpened;
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTitle),
        backgroundColor: appBarColor,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              // using currentState with question mark to ensure it's not null
              webViewKey.currentState?.reloadWebView();
            },
          )
        ],
      ),
      body: Container(
        width: mediaQuery.size.width,
        height: mediaQuery.size.height,
        child: WebViewScreen(key: webViewKey),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: _animateColor.value,
        onPressed: animate,
        child: AnimatedIcon(
          icon: AnimatedIcons.pause_play,
          progress: _animateIcon,
        ),
      ),
    );
  }
}

class WebViewScreen extends StatefulWidget {
  WebViewScreen({Key key}) : super(key: key);
  @override
  WebViewScreenState createState() => WebViewScreenState();
}

class WebViewScreenState extends State<WebViewScreen> {
  WebViewController _webViewController;
  final flutterWebViewPlugin = FlutterWebviewPlugin();
  num _stackToView = 1;

  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: WebView(
        key: UniqueKey(),
        javascriptMode: JavascriptMode.unrestricted,
        initialUrl: 'http://192.168.100.27:5200/',
        onWebResourceError: (WebResourceError error) {
          setState(() {
            appBarColor = Colors.red;
            appBarTitle = "Error: Check Connection";
            return Scaffold(
              body: Container(
                height: double.infinity,
                child: Center(
                  child: Icon(
                    Icons.wifi_off_outlined,
                    size: 200.0,
                    color: Colors.blue,
                  ),
                ),
              ),
            );
          });
        },
      ),
    );
  }

  void reloadWebView() {
    _webViewController?.reload();
  }
}
