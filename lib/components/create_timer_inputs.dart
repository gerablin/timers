import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:timers/components/buttons/main_button.dart';
import 'package:timers/components/db/isar_db.dart';
import 'package:timers/models/timer.dart';

class CreateTimerInputs extends StatelessWidget {
  const CreateTimerInputs({
    super.key,
    required this.workoutTimeController,
    required this.restTimeController,
    required this.runsController,
    required this.db,
  });

  final TextEditingController workoutTimeController;
  final TextEditingController restTimeController;
  final TextEditingController runsController;
  final IsarDb db;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text("Create new Timer"),
        // Workout time
        TextField(
          controller: workoutTimeController,
          decoration:
          InputDecoration(labelText: "Enter your workout time"),
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly
          ], // Only numbers can be entered
        ),
        // rest time
        TextField(
          controller: restTimeController,
          decoration:
          InputDecoration(labelText: "Enter your rest time"),
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly
          ], // Only numbers can be entered
        ),
        // runs
        TextField(
          controller: runsController,
          decoration:
          new InputDecoration(labelText: "Enter your runs"),
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly
          ], // Only numbers can be entered
        ),
        MainButton(
            text: "Create Workout",
            callback: () {
              if (workoutTimeController.text.isNotEmpty &&
                  restTimeController.text.isNotEmpty &&
                  runsController.text.isNotEmpty) {
                db.saveWorkout(WorkoutTimer(
                    workoutCountDown:
                    int.parse(workoutTimeController.text),
                    restCountDown: int.parse(restTimeController.text),
                    runs: int.parse(runsController.text)));
                Navigator.pop(context);
              } else {
                print("Something was empty"
                    "${workoutTimeController.text} Workout Input"
                    "${restTimeController.text} Rest Input"
                    "${runsController.text} Run Input");
              }
            })
      ],
    );
  }
}