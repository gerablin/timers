import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:timers/utils/size_config.dart';

import '../models/timer.dart';

WorkoutTimer workoutTimer =
    WorkoutTimer(workoutCountDown: 3, restCountDown: 2, runs: 3);

List<WorkoutTimer> workouts = [workoutTimer];

class OverviewScreen extends StatelessWidget {
  const OverviewScreen({super.key});

  void _navigateToWorkout(BuildContext context) {
    context.push('/timer/13');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Dein Timer"),
      ),
      body: Column(
        children: [
          Text("welcome"),
          WorkoutList(onClick: () => _navigateToWorkout(context))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToWorkout(context),
        child: Icon(Icons.add),
      ),
    );
  }
}

class WorkoutList extends StatelessWidget {
  const WorkoutList({super.key, required this.onClick});

  final VoidCallback onClick;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: SizeConfig.blockSizeHorizontal * 4),
      child: Column(
        children: [
          ...workouts.map((workout) => WorkoutCard(
                workout: workout,
                onClick: onClick,
              ))
        ],
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
