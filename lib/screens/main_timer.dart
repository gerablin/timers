import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:timers/components/buttons/main_button.dart';
import 'package:timers/components/buttons/secondary_button.dart';
import 'package:timers/components/db/isar_db.dart';
import 'package:timers/components/timer/countdown.dart';
import 'package:timers/models/timer.dart';
import 'package:timers/utils/app_colors.dart';
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
  bool isWorkoutFinished = false;
  AudioPlayer player = AudioPlayer();

  @override
  void initState() {
    _initFirstTimer();
    super.initState();
  }

  void _initFirstTimer() async {
    await player.setSource(AssetSource('sounds/ding.m4a'));
    final workoutTimer = await widget.db.getWorkoutTimerById(widget.workoutId);
    timers = workoutTimer!.generateCountdowns();
    currentTimer = timers[0].first;
    text = currentTimer!;
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: currentTimer!),
    );
    timers.removeAt(0);
    _resetTimer();
  }

  void _setupNextTimer() {
    player.resume();
    setState(() {
      if (timers.isNotEmpty) {
        currentTimer = timers[0].first;
        _controller?.duration = Duration(seconds: currentTimer!);
        timers.removeAt(0);
      } else {
        _workoutFinished();
      }
    });
    setState(() {
      Future.delayed(Duration(milliseconds: 200));
      _startPauseTimer();
      _startPauseTimer();
    });
  }

  void _workoutFinished() {
        setState(() {
      isWorkoutFinished = true;
    });
  }

  void _startPauseTimer() {
    setState(() {
      isPlaying ? _controller?.stop() : _controller?.forward();
      isPlaying = !isPlaying;
    });
  }

  void _resetTimer({bool autoPlay = false}) {
    setState(() {
      _controller!.reset();
      _controller!.stop();
      isPlaying = false;
    });
  }

  void _onTimerUpdate(double value, {bool autoPlay = false}) {
    setState(() {
      if (value != 0.0) {
        text = value.toInt();
        progress = value / currentTimer!;
        if (autoPlay) {
          _startPauseTimer();
        }
      }
    });
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Timer"),
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
                    color: AppColors.accentColor,
                    strokeWidth: 10.0,
                    strokeCap: StrokeCap.round,
                    backgroundColor: AppColors.lightBackgroundColor,
                  ),
                ),
                if (_controller == null || currentTimer == null)
                  Center(
                    child: CircularProgressIndicator(),
                  )
                else if (isWorkoutFinished)
                  Text("Workout Finished")
                else
                  Countdown(
                    seconds: currentTimer!,
                    build: (BuildContext context, double time) {
                      return Text(text.toString(),
                          style: TextStyle(fontSize: 48,
                          fontWeight: FontWeight.w700));
                    },
                    onTimerUpdate: _onTimerUpdate,
                    animationController: _controller,
                    onFinished: _setupNextTimer,
                  ),
              ],
            ),
          ),
          buildButtons(isWorkoutFinished)
        ],
      ),
    );
  }

  Padding buildButtons(bool isWorkoutFinished) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: SizeConfig.blockSizeVertical * 4,
          horizontal: SizeConfig.blockSizeHorizontal * 4),
      child: Column(
        children: [
         if(!isWorkoutFinished) MainButton(
            text: isPlaying ? "Stop" : "Start",
            callback: _startPauseTimer,
          ),
          if(!isWorkoutFinished) SecondaryButton(
            callback: _resetTimer,
            text: "Reset",
          )
          else MainButton(
            text: "Go Back",
            callback: () => _navigateBackToOverview(context),
          ),
        ],
      ),
    );
  }

  _navigateBackToOverview(BuildContext context) {
    context.pop(context);
  }
}
