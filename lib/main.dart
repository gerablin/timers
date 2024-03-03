import 'package:flutter/material.dart';
import 'package:timers/timer/timer_controller.dart';
import 'package:timers/timer/timer_countdown.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final CountdownController _controller = CountdownController(autoStart: false);
  bool isPlaying = false;
  double progressValue = 1.0;
  final initialCountdown = 10;
  double currentValue = 0;

  @override
  void initState() {
    super.initState();

    _controller.pause();
  }

  void _startStopTimer() {
    isPlaying ? _controller.pause() : _controller.start();
    isPlaying = !isPlaying;
    setState(() {});
  }

  void _updateProgress() {
    debugPrint("${_controller.currentMicroSeconds}");
    // progressValue = initialCountdown ;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircularProgressIndicator(
              value: progressValue,
            ),
            const Text(
              "Let's go",
            ),
            MainTimer(
              controller: _controller,
              initialCountdown: initialCountdown,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _startStopTimer(),
        child: isPlaying ? Icon(Icons.stop) : Icon(Icons.play_arrow),
      ),
    );
  }
}

class MainTimer extends StatelessWidget {
  const MainTimer(
      {super.key, required this.controller, required this.initialCountdown});

  final CountdownController controller;
  final int initialCountdown;

  @override
  Widget build(BuildContext context) {
    return Countdown(
      controller: controller,
      seconds: initialCountdown,
      build: (BuildContext context, double time) =>
          Text(time.toString(), style: TextStyle(fontSize: 24)),
      interval: Duration(milliseconds: 100),
    );
  }
}
