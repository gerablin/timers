import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:timers/components/db/isar_db.dart';
import 'package:timers/utils/size_config.dart';

import '../models/timer.dart';

class OverviewScreen extends StatelessWidget {
  OverviewScreen({super.key});

  final IsarDb db = IsarDb();

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
          WorkoutList(
            onClick: () => _navigateToWorkout(context),
            db: db,
          )
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
  const WorkoutList({super.key, required this.onClick, required this.db});

  final VoidCallback onClick;
  final IsarDb db;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: SizeConfig.blockSizeHorizontal * 4),
      child: Column(
        children: [
          FutureBuilder(
              future: db.getAllWorkoutTimers(),
              builder: (context, snapshot) {
                if (snapshot.hasError) return Text(snapshot.error.toString());

                if (snapshot.hasData) {
                  final List<WorkoutCard> workoutCards = [];
                  final workouts = snapshot.data;
                  for (var workout in workouts!) {
                    workoutCards.add(WorkoutCard(
                      workout: workout,
                      onClick: onClick,
                    ));
                  }
                  return Column(
                    children: [...workoutCards],
                  );
                }
                return const Center(child: CircularProgressIndicator());
              }),
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
