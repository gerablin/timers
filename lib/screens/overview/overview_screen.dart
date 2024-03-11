import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:isar/isar.dart';
import 'package:timers/components/buttons/main_button.dart';
import 'package:timers/screens/overview/components/create_timer_inputs.dart';
import 'package:timers/components/db/isar_db.dart';
import 'package:timers/screens/overview/components/workout_list.dart';
import 'package:timers/screens/overview/create_timer_bottom_sheet.dart';
import 'package:timers/utils/size_config.dart';

import '../../models/timer.dart';

class OverviewScreen extends StatelessWidget {
  OverviewScreen({super.key});

  final IsarDb db = IsarDb();

  void _openCreateTimerSheet(BuildContext context,) {
    showCreateTimerBottomSheet(context, db);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Dein Timer"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text("welcome"),
            WorkoutList(
              db: db,
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openCreateTimerSheet(context),
        child: Icon(Icons.add),
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
    return InkWell(
      onTap: onClick,
      child: Card(
          child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: SizeConfig.blockSizeVertical,
            horizontal: SizeConfig.blockSizeHorizontal * 4),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("workout"),
                Text("${workout.workoutCountDown} seconds")
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("rest"),
                Text("${workout.restCountDown} seconds")
              ],
            )
          ],
        ),
      )),
    );
  }
}
