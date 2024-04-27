import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:timers/components/db/isar_db.dart';
import 'package:timers/components/icons/cooldown_icon.dart';
import 'package:timers/components/icons/fire_icon.dart';
import 'package:timers/models/workout_timer.dart';
import 'package:timers/screens/overview/components/edit_timer_bottom_sheet.dart';
import 'package:timers/utils/app_colors.dart';
import 'package:timers/utils/size_config.dart';

import '../../main_timer.dart';

class WorkoutList extends StatelessWidget {
  const WorkoutList({
    super.key,
    required this.db,
    this.isEditMode = false,
  });

  final IsarDb db;
  final bool isEditMode;

  void _navigateToWorkout(BuildContext context, int id) {
    context.push('/timer/${id.toString()}');
  }

  void _onWorkoutClicked(BuildContext context, WorkoutTimer workoutTimer) {
    if (isEditMode) {
      showEditTimerBottomSheet(context, db, workoutTimer);
    } else {
      Future.delayed(const Duration(milliseconds: 300), () {
        _navigateToWorkout(context, workoutTimer.id);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
      EdgeInsets.symmetric(horizontal: SizeConfig.blockSizeHorizontal * 4),
      child: SingleChildScrollView(
        child: Column(
          children: [
            StreamBuilder(
                stream: db.listenToWorkoutTimers(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) return Text(snapshot.error.toString());

                  if (snapshot.hasData) {
                    final List<Widget> workoutCards = [];
                    final workouts = snapshot.data;
                    for (var workout in workouts!) {
                      workoutCards.add(
                        Dismissible(
                          key: Key(workout.id.toString()),
                          direction: DismissDirection.endToStart,
                          onDismissed: (_) => {db.deleteWorkout(workout.id)},
                          child: WorkoutCard(
                              workout: workout,
                              isEditMode: isEditMode,
                              onClick: () =>
                                  _onWorkoutClicked(context, workout)),
                        ),
                      );
                    }
                    return Column(
                      children: [...workoutCards],
                    );
                  }
                  return const Center(child: CircularProgressIndicator());
                }),
          ],
        ),
      ),
    );
  }
}

class WorkoutCard extends StatelessWidget {
  const WorkoutCard({
    super.key,
    required this.workout,
    required this.onClick,
    required this.isEditMode,
  });

  final VoidCallback onClick;
  final WorkoutTimer workout;
  final bool isEditMode;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Stack(
        children: [
          Card(
            child: OpenContainer(
              closedShape:RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ) ,
              openColor: Colors.transparent,
              closedColor: Colors.transparent,
              openBuilder: (BuildContext context, void Function() action) {
                Future.delayed(const Duration(milliseconds: 300), () {});
                return MainTimer(
                  workoutId: workout.id,
                );
              },
              closedBuilder:  (BuildContext context, void Function() action) {
                return Padding(
                  padding: EdgeInsets.only(
                      top: SizeConfig.blockSizeVertical,
                      bottom: SizeConfig.blockSizeVertical * 2,
                      left: SizeConfig.blockSizeHorizontal * 4,
                      right: SizeConfig.blockSizeHorizontal * 4),
                  child: Column(
                    children: [
                      Text(
                        workout.name,
                        style: const TextStyle(fontSize: 20.0, letterSpacing: 1.2),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.directions_run_outlined,
                                color: AppColors.accentColor,
                              ),
                              Padding(padding: EdgeInsets.symmetric(
                                  horizontal: SizeConfig.blockSizeHorizontal )),
                              const Text("Runs"),
                            ],
                          ),
                          Text("${workout.runs}")
                        ],
                      ),
                      Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: SizeConfig.blockSizeVertical * 0.5)),
                      WorkoutTimeRow(workout: workout),
                      Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: SizeConfig.blockSizeVertical * 0.5)),
                      RestTimeRow(workout: workout)
                    ],
                  ),
                );
              },

            ),
          ),
          if (isEditMode)
            Positioned.fill(
              child: GestureDetector(
                onTap: onClick,
                child: Card(
                  color: Colors.black.withOpacity(0.5),
                  child: const Center(
                    child: Text(
                      'Click to Edit',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class RestTimeRow extends StatelessWidget {
  const RestTimeRow({
    super.key,
    required this.workout,
  });

  final WorkoutTimer workout;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
         Row(
          children: [
            const CooldownIcon(),
            Padding(padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.blockSizeHorizontal )),
            const Text("Time"),
          ],
        ),
        Text("${workout.restCountDown} s")
      ],
    );
  }
}

class WorkoutTimeRow extends StatelessWidget {
  const WorkoutTimeRow({
    super.key,
    required this.workout,
  });

  final WorkoutTimer workout;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
         Row(
          children: [
            const FireIcon(),
            Padding(padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.blockSizeHorizontal )),
            const Text("Time"),
          ],
        ),
        WorkoutTimeText(workout: workout)
      ],
    );
  }
}

class WorkoutTimeText extends StatelessWidget {
  const WorkoutTimeText({
    super.key,
    required this.workout,
  });

  final WorkoutTimer workout;

  String getWorkoutTimerText() {
    String text = "";
    if (workout.workoutDurations.isEmpty) {
      return "${workout.workoutCountDown} s";
    } else {
      for (var i = 0; i < workout.workoutDurations.length; i++) {
        if (i != 0) text = text + ", ";
        text = text + "${workout.workoutDurations[i]} s";
      }
    }
    return text;
  }

  @override
  Widget build(BuildContext context) {
    return Text(getWorkoutTimerText());
  }
}
