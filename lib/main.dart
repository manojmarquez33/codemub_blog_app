import 'dart:async';

import 'package:codemub_blog_web/JavaPage.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'C_Program.dart';
import 'Flutter_page.dart';
import 'about.dart';
import 'home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  int index = 0;
  late WebViewController controller;

  final screens = [
    HomeApp(),
    FlutterPage(),
    JavaPage(),
    C_Program(),
  ];

  //final String phoneNumber = '+914273572977';

  /*void _openWhatsAppChat() async {
    final url = 'https://wa.me/$phoneNumber';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Could not launch WhatsApp.'),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      );
    }
  }*/

  Future<bool> _onBackPressed() async {
    if (index == 0) {
      // Home page is currently displayed
      bool shouldExit = await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Exit Confirmation'),
          content: Text('Do you want to exit?'),
          actions: [
            TextButton(
              child: Text('Yes'),
              onPressed: () => Navigator.pop(context, true),
            ),
            TextButton(
              child: Text('No'),
              onPressed: () => Navigator.pop(context, false),
            ),
          ],
        ),
      );

      if (shouldExit == true) {
        return true;
      } else {
        return false;
      }
    } else {
      if (await controller.canGoBack()) {
        controller.goBack();
        return false;
      }
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        extendBody: true,
        appBar: AppBar(
          title: Text('CodeMub Blog'),
          backgroundColor: Color(0xFF0648b3),
        ),
        drawer: Drawer(
          child: Column(
            children: [
              UserAccountsDrawerHeader(
                accountName: Text('CodeMub'),
                accountEmail: Text('codemub@gmail.com'),
                currentAccountPicture: Image.asset(
                  'assets/logo.png',
                ),
                decoration: BoxDecoration(
                  color: Color(0xFF0648b3),
                ),
              ),
              ListTile(
                title: Text('Login'),
                leading: Icon(Icons.login),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => C_Program()));
                },
              ),
              ListTile(
                title: Text('About us'),
                leading: Icon(Icons.person_pin),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AboutPage()));
                },
              ),
              Divider(
                height: 5,
              ),
              /*ListTile(
                title: Text('Call Now'),
                leading: Icon(Icons.phone),
                //Tap: _makePhoneCall,
              ),
              ListTile(
                title: Text('WhatsApp'),
                leading: Icon(Icons.message),
                onTap: _openWhatsAppChat,
              )*/
            ],
          ),
        ),
        body: screens[index],
        bottomNavigationBar: NavigationBarTheme(
          data: NavigationBarThemeData(
            indicatorColor: Color(0xFF0648b3),
            labelTextStyle: MaterialStateProperty.all(
                TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
            iconTheme: MaterialStateProperty.resolveWith<IconThemeData?>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.selected)) {
                  return IconThemeData(
                      color: Colors.white); // Set selected icon color to white
                } else {
                  return IconThemeData(
                      color: Colors.black); // Set unselected icon color
                }
              },
            ),
          ),
          child: NavigationBar(
            height: 70,
            backgroundColor: Color(0xFFf1f5fb),
            selectedIndex: index,
            onDestinationSelected: (index) =>
                setState(() => this.index = index),
            destinations: [
              NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
              NavigationDestination(
                  icon: Icon(Icons.gamepad), label: 'Flutter'),
              NavigationDestination(icon: Icon(Icons.code), label: 'Java'),
              NavigationDestination(icon: Icon(Icons.computer), label: 'C '),
            ],
          ),
        ),
      ),
    );
  }
}
