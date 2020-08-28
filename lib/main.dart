import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sctproject/pages/customNavigationBar.dart';
import 'package:sctproject/utils/theme.dart';

void main() {
  runApp(MyApp());
  SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
}

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
