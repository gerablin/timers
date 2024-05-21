import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:timers/utils/size_config.dart';

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
