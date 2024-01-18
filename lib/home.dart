import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(HomeApp());
}

class HomeApp extends StatelessWidget {
  const HomeApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WebViewPage(),
    );
  }
}

class WebViewPage extends StatefulWidget {
  const WebViewPage({Key? key}) : super(key: key);

  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  late WebViewController controller;
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Stack(
        children: [
          WillPopScope(
            onWillPop: () async {
              if (await controller.canGoBack()) {
                // Check if WebView can go back
                controller.goBack();
                return false; // Prevent default back button behavior
              }
              return true; // Allow default back button behavior
            },
            child: WebView(
              javascriptMode: JavascriptMode.unrestricted,
              initialUrl: 'https://blog.codemub.com/',
              onWebViewCreated: (controller) {
                this.controller = controller;
              },
              onPageFinished: (String url) {
                controller
                    .evaluateJavascript("javascript:(function() { " +
                        "var head = document.getElementsByTagName('header')[0];" +
                        "head.parentNode.removeChild(head);" +
                        "var footer = document.getElementsByTagName('footer')[0];" +
                        "footer.parentNode.removeChild(footer);" +
                        "})()")
                    .then((value) =>
                        debugPrint('Page finished loading Javascript'))
                    .catchError((onError) => debugPrint('$onError'));

                setState(() {
                  isLoading =
                      false; // Set isLoading to false when the page finishes loading
                });
              },
            ),
          ),
          if (isLoading)
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 80.0),
                  Padding(
                    padding: EdgeInsets.only(left: 56.0),
                    child: Text(
                      '',
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
