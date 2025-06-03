import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(const MyTimerApp());
}

class MyTimerApp extends StatelessWidget {
  const MyTimerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyTimer',
      theme: ThemeData(primarySwatch: Colors.blueGrey),
      home: const TimerHomePage(),
    );
  }
}

class TimerHomePage extends StatefulWidget {
  const TimerHomePage({super.key});

  @override
  State<TimerHomePage> createState() => _TimerHomePageState();
}

class _TimerHomePageState extends State<TimerHomePage> {
  int _secondsRemaining = 1500;
  Timer? _timer;
  bool _isRunning = false;
  final String _title = 'Pomodoro Session';



  @override
  void initState() {
    super.initState();

  }


  void _startTimer() {
    if (_timer != null) _timer!.cancel();

    setState(() {
      _isRunning = true;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() {
          _secondsRemaining--;
        });

        if (_secondsRemaining % 60 == 0) {
        }
      } else {
        timer.cancel();
        setState(() {
          _isRunning = false;
        });
      }
    });
  }



  void _resetTimer() {
    if (_timer != null) _timer!.cancel();
    setState(() {
      _secondsRemaining = 1500;
      _isRunning = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final minutes = (_secondsRemaining ~/ 60).toString().padLeft(2, '0');
    final seconds = (_secondsRemaining % 60).toString().padLeft(2, '0');

    return Scaffold(
      appBar: AppBar(title: Text(_title)),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text('$minutes:$seconds', style: const TextStyle(fontSize: 60)),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: _isRunning ? null : _startTimer,
            child: const Text('Start'),
          ),
          ElevatedButton(
            onPressed: _resetTimer,
            child: const Text('Reset'),
          ),
        ]),
      ),
    );
  }
}
