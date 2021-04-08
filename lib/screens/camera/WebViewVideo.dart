import 'dart:io';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/material.dart';

final webViewKey = GlobalKey<WebViewScreenState>();

class WebViewPage extends StatefulWidget {
  @override
  WebViewPageState createState() => WebViewPageState();
}

class WebViewPageState extends State<WebViewPage> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Video Live Feed"),
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
        child: WebViewScreen(key: webViewKey)
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
  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return WebView(
      key: UniqueKey(),
      javascriptMode: JavascriptMode.unrestricted,
      initialUrl: 'http://192.168.100.4:5000/',
    );
  }

  void reloadWebView() {
    _webViewController?.reload();
  }
}
