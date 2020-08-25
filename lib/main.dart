import 'package:flutter/material.dart';
import 'package:sctproject/pages/customNavigationBar.dart';
import 'package:sctproject/utils/theme.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: basicTheme(),
      home: CustomNavBar(),
    );
  }
}

class SystemChrome {}
