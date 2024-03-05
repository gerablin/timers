import 'package:flutter/material.dart';
import 'package:timers/components/buttons/main_button.dart';
import 'package:timers/components/buttons/secondary_button.dart';
import 'package:timers/components/timer/countdown.dart';
import 'package:timers/models/timer.dart';
import 'package:timers/utils/size_config.dart';

class MainTimer extends StatefulWidget {
  MainTimer({
    super.key,
    required this.initialCountdown,
  });

  final int initialCountdown;

  @override
  State<MainTimer> createState() => _MainTimerState();
}

class _MainTimerState extends State<MainTimer> with TickerProviderStateMixin {
  double progress = 1.0;
  bool isPlaying = false;
  late AnimationController _controller;

  late int currentTimer;
  WorkoutTimer workoutTimer =
      WorkoutTimer(workoutCountDown: 3, restCountDown: 2, runs: 3);
  late List<Pair<int, bool>> timers;
  late int text;
  @override
  void initState() {
    timers = workoutTimer.generateCountdowns();
    currentTimer = timers[0].first;
    text = currentTimer;
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: currentTimer),
    );
    _setupNextTimer();
    super.initState();
  }

  void _setupNextTimer() {
    if (timers.isNotEmpty) {
      currentTimer = timers[0].first;
      _controller.duration = Duration(seconds: currentTimer);
      timers.removeAt(0);
      setState(() {});
    } else {
      //TODO handle finish
      print("WORKOUT DONE");
    }
    _resetTimer();
    setState(() {});
  }

  void _startPauseTimer() {
    isPlaying ? _controller.stop() : _controller.forward();
    isPlaying = !isPlaying;
    setState(() {});
  }

  void _resetTimer() {
    _controller.reset();
    _controller.stop();
    isPlaying = false;
    setState(() {});
  }

  void _onTimerUpdate(double value) {
    text = value.toInt();
    print("ontimer update with $value");
    print("currentTimer in update : $currentTimer");
    setState(() {
      progress = value / currentTimer;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Runde X"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 4),
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: [
                SizedBox(
                  height: SizeConfig.blockSizeHorizontal * 80,
                  width: SizeConfig.blockSizeHorizontal * 80,
                  child: CircularProgressIndicator(
                    value: progress,
                  ),
                ),
                Countdown(
                  seconds: currentTimer,
                  build: (BuildContext context, double time) {
                    return Text(text.toString(),
                        style: TextStyle(fontSize: 24));
                  },
                  onTimerUpdate: _onTimerUpdate,
                  animationController: _controller,
                  onFinished: _setupNextTimer,
                ),
              ],
            ),
          ),
          buildButtons()
        ],
      ),
    );
  }

  Padding buildButtons() {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: SizeConfig.blockSizeVertical * 4,
          horizontal: SizeConfig.blockSizeHorizontal * 4),
      child: Column(
        children: [
          MainButton(
            text: isPlaying ? "Stop" : "Start",
            callback: _startPauseTimer,
          ),
          SecondaryButton(
            callback: _resetTimer,
            text: "Reset",
          )
        ],
      ),
    );
  }
}
