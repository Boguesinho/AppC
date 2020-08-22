import 'package:flutter/material.dart';
import 'package:sctproject/pages/customNavigationBar.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xff505050),
      ),
      home: CustomNavBar(),
    );
  }
}

class SystemChrome {}
