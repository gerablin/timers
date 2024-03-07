import 'package:flutter/material.dart';

class Countdown extends StatefulWidget {
  final int seconds;
  final Widget Function(BuildContext, double) build;
  final Function? onFinished;
  final ValueChanged<double>? onTimerUpdate;
  final AnimationController?
      animationController;

  Countdown({
    Key? key,
    required this.seconds,
    required this.build,
    this.onTimerUpdate,
    this.onFinished,
    this.animationController,
  }) : super(key: key);

  @override
  _CountdownState createState() => _CountdownState();
}

class _CountdownState extends State<Countdown> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late int initialCountdown = widget.seconds;

  @override
  void initState() {
    super.initState();
    _controller = widget.animationController ??
        AnimationController(
          vsync: this,
          duration: Duration(seconds: widget.seconds),
        );
    //TODO: Update this animation accordingly
    _animation = Tween<double>(
      begin: _controller.duration!.inSeconds.toDouble(),
      end: 0.0,
    ).animate(_controller)
      ..addListener(() {
        if (widget.onTimerUpdate != null) {
          widget.onTimerUpdate!(_animation.value); // Notify listener
        }
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          if (widget.onFinished != null) {
            widget.onFinished!();
            // Change the begin parameter for the next animation
            _animation = Tween<double>(
              begin: _controller.duration!.inSeconds.toDouble(),
              end: 0.0,
            ).animate(_controller);
            _controller.reset();
          }
        }
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.build(context, _animation.value);
  }
}
