import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(FlutterPage());
}

class FlutterPage extends StatefulWidget {
  const FlutterPage({Key? key}) : super(key: key);

  @override
  State<FlutterPage> createState() => _FlutterPageState();
}

class _FlutterPageState extends State<FlutterPage> {
  late WebViewController _controller;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (await _controller.canGoBack()) {
          // Check if WebView can go back
          _controller.goBack();
          return false; // Prevent default back button behavior
        }
        return true; // Allow default back button behavior
      },
      child: Scaffold(
        extendBody: true,
        body: WebView(
          javascriptMode: JavascriptMode.unrestricted,
          initialUrl: 'https://blog.codemub.com/search/label/Flutter',
          onWebViewCreated: (WebViewController controller) {
            _controller = controller;
          },
          onPageFinished: (String url) {
            _controller
                .evaluateJavascript("javascript:(function() { " +
                    "var head = document.getElementsByTagName('header')[0];" +
                    "head.parentNode.removeChild(head);" +
                    "var footer = document.getElementsByTagName('footer')[0];" +
                    "footer.parentNode.removeChild(footer);" +
                    "})()")
                .then((value) => debugPrint('Page finished loading Javascript'))
                .catchError((onError) => debugPrint('$onError'));
          },
        ),
      ),
    );
  }
}
