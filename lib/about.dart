import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AboutPage(),
    );
  }
}

class AboutPage extends StatefulWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  late WebViewController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: Text('About us'),
        backgroundColor: Color(0xFF0648b3),
      ),
      body: WebView(
        javascriptMode: JavascriptMode.unrestricted,
        initialUrl: 'https://logykinfotech.com/about.php',
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
              .then((value) => debugPrint('Page finished loading Javascript'))
              .catchError((onError) => debugPrint('$onError'));
        },
      ),
    );
  }
}
