import 'package:flutter/material.dart';

import 'customNavigationBar.dart';

class TimerCubo extends StatelessWidget {
  const TimerCubo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text('TIMER'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Ventana principal para TIMER',
            ),
          ],
        ),
      ),
    );
  }
}
