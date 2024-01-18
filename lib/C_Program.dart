import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(C_Program());
}

class C_Program extends StatefulWidget {
  const C_Program({Key? key}) : super(key: key);

  @override
  State<C_Program> createState() => _C_ProgramState();
}

class _C_ProgramState extends State<C_Program> {
  late WebViewController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: WillPopScope(
        onWillPop: () async {
          if (await controller.canGoBack()) {
            controller.goBack();
            return false;
          }
          return true;
        },
        child: WebView(
          javascriptMode: JavascriptMode.unrestricted,
          initialUrl: 'https://blog.codemub.com/search/label/C%20program',
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
      ),
    );
  }
}
