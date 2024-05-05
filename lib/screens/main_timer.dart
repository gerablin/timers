import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:timers/components/buttons/main_button.dart';
import 'package:timers/components/buttons/secondary_button.dart';
import 'package:timers/components/db/isar_db.dart';
import 'package:timers/components/icons/cooldown_icon.dart';
import 'package:timers/components/icons/fire_icon.dart';
import 'package:timers/components/timer/countdown.dart';
import 'package:timers/models/workout_timer.dart';
import 'package:timers/utils/app_colors.dart';
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
  @override
  void initState() {
    WakelockPlus.enable();
    _initFirstTimer();
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

  void _updateTimerSubtitle() {
    String aggregateRuns = (int.parse(runs) * (workoutTimer!.sessions!)).toString();
    String workoutAmount = "(${currentRun.toString()}/$aggregateRuns)";
    bool isRestTimer = timers.first.second;
    timerSubtitle = isRestTimer
        ? Strings.timerSubtitleRest
        : ("${Strings.timerSubtitleWorkout} $workoutAmount");

    timerIcon = isRestTimer ? const CooldownIcon() : const FireIcon();
    if (!isRestTimer) currentRun++;
  }

  @override
  void dispose() {
    WakelockPlus.disable();
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(Strings.mainTimerAppBar),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
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
                      const Center(
                        child: CircularProgressIndicator(),
                      )
                    else if (isWorkoutFinished)
                      const Text(Strings.workoutFinishedTitle)
                    else
                      Countdown(
                        seconds: currentTimer!,
                        build: (BuildContext context, double time) {
                          return Text(text.toString(),
                              style: const TextStyle(
                                  fontSize: 48, fontWeight: FontWeight.w700));
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
