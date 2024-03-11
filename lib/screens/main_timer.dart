import 'package:flutter/material.dart';
import 'package:timers/components/buttons/main_button.dart';
import 'package:timers/components/buttons/secondary_button.dart';
import 'package:timers/components/db/isar_db.dart';
import 'package:timers/components/timer/countdown.dart';
import 'package:timers/models/timer.dart';
import 'package:timers/utils/size_config.dart';

class MainTimer extends StatefulWidget {
  MainTimer({
    super.key,
    required this.workoutId,
  });

  final int workoutId;
  final IsarDb db = IsarDb();

  @override
  State<MainTimer> createState() => _MainTimerState();
}

class _MainTimerState extends State<MainTimer> with TickerProviderStateMixin {
  double progress = 1.0;
  bool isPlaying = false;
  AnimationController? _controller;

  int? currentTimer;
  late List<Pair<int, bool>> timers = List.empty();
  late int text;

  @override
  void initState() {
    _fetchWorkoutTimer();
    super.initState();
  }

  void _fetchWorkoutTimer() async {
    final workoutTimer = await widget.db.getWorkoutTimerById(widget.workoutId);
    timers = workoutTimer!.generateCountdowns();
    currentTimer = timers[0].first;
    text = currentTimer!;
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: currentTimer!),
    );
    _setupNextTimer();
  }

  void _setupNextTimer() {
    setState(() {
      if (timers.isNotEmpty) {
        currentTimer = timers[0].first;
        _controller?.duration = Duration(seconds: currentTimer!);
        debugPrint(" new controller start time: ${_controller!.duration}");
        timers.removeAt(0);
      } else {
        //TODO handle finish
        debugPrint("WORKOUT DONE");
      }
      _resetTimer();
    });
  }

  void _startPauseTimer() {
    setState(() {
      isPlaying ? _controller?.stop() : _controller?.forward();
      isPlaying = !isPlaying;
    });
  }

  void _resetTimer() {
    setState(() {
      _controller!.reset();
      _controller!.stop();
      isPlaying = false;
    });
  }

  void _onTimerUpdate(double value) {
    setState(() {
      if (value != 0.0) {
        text = value.toInt();
        debugPrint("ontimer update with $value");
        progress = value / currentTimer!;
      }
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
                if(_controller == null || currentTimer == null) Center(
                  child: CircularProgressIndicator(),
                )
                else Countdown(
                  seconds: currentTimer!,
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
