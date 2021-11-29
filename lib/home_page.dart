import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int? _selectedIndex;
  final List<Widget> _widgetOptions = [const Catalogue(), const Contact(), Cgu()];

  @override
  void initState() {
    _selectedIndex = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void _onItemTap(int index) {
      setState(() {
        _selectedIndex = index;
      });
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
        home: Scaffold(
      appBar: AppBar(
        title: const Text('Green House'),
        backgroundColor: Colors.lightGreen,
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex!),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.lightGreen,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag_outlined, color: Colors.lightGreen,),
            label: 'Catalogue',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.contact_phone_outlined, color: Colors.lightGreen,), 
              label: 'Contact',
              
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.my_library_books_outlined, color: Colors.lightGreen,), 
              label: 'CGU',
          ),
        ],
        currentIndex: _selectedIndex!,
        onTap: _onItemTap,
      ),
    ));
  }
}

class Catalogue extends StatelessWidget {
  const Catalogue({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: WebView(
        initialUrl: "http://www.greenhouse-coffeeshop.com/",
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}

class Contact extends StatelessWidget {
  const Contact({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: WebView(
        initialUrl: "http://www.greenhouse-coffeeshop.com/nous-contacter",
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}

class Cgu extends StatelessWidget {
  late WebViewController controller;

  void loadLocalHtml() async {
    
    final html = await rootBundle.loadString('assets/index.html');
    final url = Uri.dataFromString(
      html,
      mimeType: 'text/html',
      encoding: Encoding.getByName('utf-8'),
    ).toString();
    controller.loadUrl(url);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebView(
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (controller) {
          this.controller = controller;
          loadLocalHtml();
        },
      ),
    );
  }
}
