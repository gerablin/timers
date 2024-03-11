import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:timers/components/db/isar_db.dart';
import 'package:timers/screens/overview/overview_screen.dart';
import 'package:timers/utils/size_config.dart';

class WorkoutList extends StatelessWidget {
  const WorkoutList({super.key, required this.db});

  final IsarDb db;

  void _navigateToWorkout(BuildContext context, int id) {
    context.push('/timer/${id.toString()}');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
      EdgeInsets.symmetric(horizontal: SizeConfig.blockSizeHorizontal * 4),
      child: Column(
        children: [
          StreamBuilder(
              stream: db.listenToWorkoutTimers(),
              builder: (context, snapshot) {
                if (snapshot.hasError) return Text(snapshot.error.toString());

                if (snapshot.hasData) {
                  final List<WorkoutCard> workoutCards = [];
                  final workouts = snapshot.data;
                  for (var workout in workouts!) {
                    workoutCards.add(WorkoutCard(
                      workout: workout,
                      onClick:() => _navigateToWorkout(context,workout.id),
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
