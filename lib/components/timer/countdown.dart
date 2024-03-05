
import 'package:flutter/material.dart';

class Countdown extends StatefulWidget {
  final int seconds;
  final Widget Function(BuildContext, double) build;
  final Function? onFinished;
  final ValueChanged<double>? onTimerUpdate;
  final AnimationController?
  animationController; // External animation controller

  Countdown({
    Key? key,
    required this.seconds,
    required this.build,
    this.onTimerUpdate, // Listener callback
    this.onFinished,
    this.animationController, // External animation controller
  }) : super(key: key);

  @override
  _CountdownState createState() => _CountdownState();
}

class _CountdownState extends State<Countdown>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;


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
      begin: widget.seconds.toDouble(),
      end: 0.0,
    ).animate(_controller)
      ..addListener(() {
        if (widget.onTimerUpdate != null) {
          widget.onTimerUpdate!(_animation.value); // Notify listener
        }
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          if (widget.onFinished != null) {
            widget.onFinished!();
            widget.onTimerUpdate!(_controller.duration!.inSeconds.toDouble());
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