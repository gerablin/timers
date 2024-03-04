import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timers/provider/timer_provider.dart';
import 'package:timers/timer/timer_controller.dart';
import 'package:timers/timer/timer_countdown.dart';

void main() {
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Dein Timer"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
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

class MainTimer extends StatefulWidget {
  MainTimer({
    super.key,
    required this.controller,
    required this.initialCountdown,
  });

  final CountdownController controller;
  final int initialCountdown;

  @override
  State<MainTimer> createState() => _MainTimerState();
}

class _MainTimerState extends State<MainTimer> {

  double progress = 1.0;

  @override
  void initState() {
    super.initState();
  }

  void _onTimerUpdate(double value) {
    setState(() {
      progress = value;
      print(progress);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircularProgressIndicator(
          value: progress,
        ),
        Countdown(
          controller: widget.controller,
          seconds: widget.initialCountdown,
          build: (BuildContext context, double time) {
            return Text(time.toString(), style: TextStyle(fontSize: 24));
          },
          interval: Duration(milliseconds: 100),
          onTimerUpdate: _onTimerUpdate,
        ),
      ],
    );
  }
}
