import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(Contact());
}

class Contact extends StatefulWidget {
  const Contact({Key? key}) : super(key: key);

  @override
  State<Contact> createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  late WebViewController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: WebView(
        javascriptMode: JavascriptMode.unrestricted,
        initialUrl: 'https://logykinfotech.com/contact.php',
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
