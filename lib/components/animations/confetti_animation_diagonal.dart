
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class ConfettiAnimationDiagonal extends StatelessWidget {
  const ConfettiAnimationDiagonal({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const RiveAnimation.asset(
      'assets/animations/confetti-diagonal.riv',
      fit: BoxFit.fill,
    );
  }
}