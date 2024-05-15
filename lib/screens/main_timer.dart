import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:rive/rive.dart';
import 'package:timers/components/buttons/main_button.dart';
import 'package:timers/components/buttons/secondary_button.dart';
import 'package:timers/components/db/isar_db.dart';
import 'package:timers/components/icons/cooldown_icon.dart';
import 'package:timers/components/icons/fire_icon.dart';
import 'package:timers/components/timer/countdown.dart';
import 'package:timers/models/workout_timer.dart';
import 'package:timers/utils/app_colors.dart';
import 'package:timers/utils/constants.dart';
import 'package:timers/utils/size_config.dart';
import 'package:timers/utils/strings.dart' as Strings;
import 'package:wakelock_plus/wakelock_plus.dart';

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
  String timerSubtitle = Strings.timerSubtitleWorkout;
  Widget timerIcon = const FireIcon();

  // subtitle helper properties
  String runs = "";
  int currentRun = 1;
  late WorkoutTimer? workoutTimer;

  //////////////////
  // rive animation
  Artboard? _riveArtboard;
  SMITrigger? _explodeConfetti;

  //////////////////
  @override
  void initState() {
    WakelockPlus.enable();
    _initFirstTimer();
    _loadAnimation();
    super.initState();
  }

  void _initFirstTimer() async {
    player.setSource(AssetSource('sounds/ding.m4a'));
    player.setReleaseMode(ReleaseMode.stop);

    workoutTimer = await widget.db.getWorkoutTimerById(widget.workoutId);

    timers = workoutTimer!.generateCountdowns();
    currentTimer = timers[0].first;
    text = currentTimer!;
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: currentTimer!),
    );
    runs = workoutTimer?.runs.toString() ?? "";
    _updateTimerSubtitle();
    timers.removeAt(0);
    _resetTimer();
  }

  void _setupNextTimer() {
    playSound();
    setState(() {
      if (timers.isNotEmpty) {
        currentTimer = timers[0].first;
        _controller?.duration = Duration(seconds: currentTimer!);
        _updateTimerSubtitle();
        timers.removeAt(0);
      } else {
        _workoutFinished();
      }
    });
    setState(() {
      Future.delayed(const Duration(milliseconds: 200));
      _startPauseTimer();
      _startPauseTimer();
    });
  }

  void playSound() {
    player.resume();
  }

  void _workoutFinished() {
    int _animationCount = 0;
    setState(() {
      isWorkoutFinished = true;
    });
    _animationCount = 0; // Reset animation count

    //initial confetti fire
    _riveArtboard?.advance(1 / 60, nested: true);
    _explodeConfetti?.fire();
    // Start a new timer
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_animationCount < 10) {
        // Trigger the animation
        _riveArtboard?.advance(1 / 60, nested: true);
        _explodeConfetti?.fire();
        _animationCount++;
      } else {
        // Stop the timer after 10 repetitions
        timer.cancel();
      }
    });
    // not sure why this is needed here, but github issue for solution is here: https://github.com/rive-app/rive-flutter/issues/329
    // _riveArtboard?.advance(1 / 60, nested: true);
    // _explodeConfetti?.fire();
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

  void _updateTimerSubtitle() {
    String aggregateRuns =
        (int.parse(runs) * (workoutTimer!.sessions!)).toString();
    String workoutAmount = "(${currentRun.toString()}/$aggregateRuns)";
    bool isRestTimer = timers.first.second;
    timerSubtitle = isRestTimer
        ? Strings.timerSubtitleRest
        : ("${Strings.timerSubtitleWorkout} $workoutAmount");

    timerIcon = isRestTimer ? const CooldownIcon() : const FireIcon();
    if (!isRestTimer) currentRun++;
  }

  void _loadAnimation() {
    rootBundle.load('assets/animations/confetti-explosion.riv').then((data) async {
      // Load the RiveFile from the binary data.
      final file = RiveFile.import(data);

      // The artboard is the root of the animation and gets drawn in the
      // Rive widget.
      final artboard = file.mainArtboard;
      var controller = StateMachineController.fromArtboard(
          artboard, riveConfettiExplosionStateMachine);
      if (controller != null) {
        artboard.addController(controller);
        _explodeConfetti = controller
            .findInput<bool>(riveConfettiExplosionStateMachineTrigger) as SMITrigger;
      }
      setState(() {
        _riveArtboard = artboard;
      });
    });
  }

  @override
  void dispose() {
    WakelockPlus.disable();
    player.dispose();
    _riveArtboard = null;
    _explodeConfetti = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(Strings.mainTimerAppBar),
      ),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(
                left: SizeConfig.blockSizeHorizontal * 10,
                bottom: SizeConfig.blockSizeVertical * 20),
            child: Align(
                alignment: Alignment.bottomLeft,
                child: ConfettiAnimation(riveArtboard: _riveArtboard)),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: SizeConfig.blockSizeHorizontal * 10,
                bottom: SizeConfig.blockSizeVertical * 20),
            child: Align(
                alignment: Alignment.bottomRight,
                child: ConfettiAnimation(riveArtboard: _riveArtboard)),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Padding(
                    padding:
                        EdgeInsets.only(top: SizeConfig.blockSizeVertical * 4),
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
                          const Center(
                            child: CircularProgressIndicator(),
                          )
                        else if (isWorkoutFinished)
                          buildFinishedWorkoutContent()
                        else
                          Countdown(
                            seconds: currentTimer!,
                            build: (BuildContext context, double time) {
                              return Text(text.toString(),
                                  style: const TextStyle(
                                      fontSize: 48,
                                      fontWeight: FontWeight.w700));
                            },
                            onTimerUpdate: _onTimerUpdate,
                            animationController: _controller,
                            onFinished: _setupNextTimer,
                          ),
                      ],
                    ),
                  ),
                  TimerSubtitle(
                      showText: !isWorkoutFinished,
                      timerIcon: timerIcon,
                      timerSubtitle: timerSubtitle)
                ],
              ),
              buildButtons(isWorkoutFinished)
            ],
          ),
        ],
      ),
    );
  }

  Stack buildFinishedWorkoutContent() {
    return Stack(
      alignment: Alignment.center,
      children: [
        const Text(Strings.workoutFinishedTitle),
        ConfettiAnimation(riveArtboard: _riveArtboard),
      ],
    );
  }

  Padding buildButtons(bool isWorkoutFinished) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: SizeConfig.blockSizeVertical * 4,
          horizontal: SizeConfig.blockSizeHorizontal * 4),
      child: Column(
        children: [
          if (!isWorkoutFinished)
            MainButton(
              text: isPlaying ? Strings.stopTimer : Strings.startTimer,
              callback: _startPauseTimer,
              isEnabled: true,
            ),
          if (!isWorkoutFinished)
            SecondaryButton(
              callback: _resetTimer,
              text: Strings.resetTimer,
            )
          else
            MainButton(
              text: Strings.goBack,
              callback: () => _navigateBackToOverview(context),
              isEnabled: true,
            ),
        ],
      ),
    );
  }

  _navigateBackToOverview(BuildContext context) {
    context.pop(context);
  }
}

class ConfettiAnimation extends StatelessWidget {
  const ConfettiAnimation({
    super.key,
    required Artboard? riveArtboard,
  }) : _riveArtboard = riveArtboard;

  final Artboard? _riveArtboard;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: SizeConfig.blockSizeHorizontal * 20,
      height: SizeConfig.blockSizeVertical * 40,
      child: _riveArtboard == null
          ? const SizedBox()
          : Rive(
              fit: BoxFit.cover,
              artboard: _riveArtboard!,
            ),
    );
  }
}

class TimerSubtitle extends StatelessWidget {
  const TimerSubtitle({
    super.key,
    required this.timerSubtitle,
    required this.timerIcon,
    required this.showText,
  });

  final String timerSubtitle;
  final Widget timerIcon;
  final bool showText;

  @override
  Widget build(BuildContext context) {
    return showText
        ? Padding(
            padding: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 4),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.blockSizeHorizontal * 2),
                  child: timerIcon,
                ),
                Text(
                  timerSubtitle,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.2,
                  ),
                ),
              ],
            ),
          )
        : const SizedBox();
  }
}
