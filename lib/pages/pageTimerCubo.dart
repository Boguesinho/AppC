import 'dart:async';
import 'package:flutter/material.dart';


class TimerCubo extends StatefulWidget {
  //const TimerCubo({Key key}) : super(key: key);

  @override
  _timerCuboState createState() => _timerCuboState();
}
  
class _timerCuboState extends State<TimerCubo>{
  
  bool _isActivado = true;
  String _timerStopText = '00:00:00';
  final _stopTimer = new Stopwatch();
  final _timeOut = const Duration(milliseconds: 1);

  void _startTimeout() {
    new Timer(_timeOut, _handleTimeout);
  }

  void _handleTimeout() {
    if (_stopTimer.isRunning) {
      _startTimeout();
    }
    setState(() {
      _setStopwatchText();
    });
  }

  void _startStopButtonPressed() {
    setState(() {
      if (_stopTimer.isRunning) {
        _isActivado = true;
        _stopTimer.stop();
      } else {
        _isActivado = false;
        _stopTimer.start();
        _startTimeout();
      }
    });
  }

  void _resetButtonPressed(){
    if(_stopTimer.isRunning){
      _startStopButtonPressed();
    }
    setState(() {
     _stopTimer.reset();
     _setStopwatchText(); 
    });
  }

  void _setStopwatchText(){
    _timerStopText = _stopTimer.elapsed.inMinutes.toString().padLeft(2,'0') + ':'+
                     (_stopTimer.elapsed.inSeconds%60).toString().padLeft(2,'0') + ':' +
                     (_stopTimer.elapsed.inMilliseconds%60).toString().padLeft(2,'0');
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text('TIMER'),
      ),
      body: _buildTimer(),
      
    );
  }
  Widget _buildTimer(){
    return Column(
      children: <Widget>[
                Expanded(
          child: FittedBox(
            fit: BoxFit.none,
            child: Text(
              _timerStopText,
              style: TextStyle(fontSize: 72),
            ),
          ),
        ),
        Center(          
          child: Column(            
            children: <Widget>[
              RaisedButton(
                child: Icon(_isActivado ? Icons.play_arrow : Icons.stop),
                onPressed: _startStopButtonPressed,
              ),
              RaisedButton(
                child: Icon(Icons.restore),
                onPressed: _resetButtonPressed,
              ),
            ],
          ),
        ),

      ],
    );
  }

}  
