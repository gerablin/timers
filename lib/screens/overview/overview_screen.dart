import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:timers/components/icons/cooldown_icon.dart';
import 'package:timers/components/icons/fire_icon.dart';
import 'package:timers/components/db/isar_db.dart';
import 'package:timers/screens/overview/components/workout_list.dart';
import 'package:timers/screens/overview/create_timer_bottom_sheet.dart';
import 'package:timers/utils/size_config.dart';

import '../../models/timer.dart';

class OverviewScreen extends StatelessWidget {
  OverviewScreen({super.key});

  final IsarDb db = IsarDb();

  void _openCreateTimerSheet(
    BuildContext context,
  ) {
    showCreateTimerBottomSheet(context, db);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Workouts"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 2),
          child: Column(
            children: [
              WorkoutList(
                db: db,
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openCreateTimerSheet(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}

class WorkoutCard extends StatelessWidget {
  const WorkoutCard({
    super.key,
    required this.workout,
    required this.onClick,
  });

  final VoidCallback onClick;
  final WorkoutTimer workout;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Card(
          child: Padding(
        padding: EdgeInsets.only(
            top: SizeConfig.blockSizeVertical,
            bottom: SizeConfig.blockSizeVertical * 2,
            left: SizeConfig.blockSizeHorizontal * 4,
            right: SizeConfig.blockSizeHorizontal * 4),
        child: Column(
          children: [
            Text("${workout.runs} Runs"),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Row(
                  children: [
                    FireIcon(),
                    Text("Time"),
                  ],
                ),
                Text("${workout.workoutCountDown} s")
              ],
            ),
            Padding(
                padding: EdgeInsets.symmetric(
                    vertical: SizeConfig.blockSizeVertical * 0.5)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Row(
                  children: [
                   CooldownIcon(),
                    Text("Time"),
                  ],
                ),
                Text("${workout.restCountDown} s")
              ],
            )
          ],
        ),
      )),
    );
  }
}
