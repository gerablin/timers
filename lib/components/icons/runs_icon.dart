import 'package:flutter/material.dart';
import 'package:timers/utils/app_colors.dart';

class RunsIcon extends StatelessWidget {
  const RunsIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return const Icon(
      Icons.directions_run_outlined,
      color: AppColors.accentColor,
    );
  }
}
