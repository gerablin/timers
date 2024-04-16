import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:timers/components/buttons/main_button.dart';
import 'package:timers/components/db/isar_db.dart';
import 'package:timers/models/workout_timer.dart';
import 'package:timers/utils/app_colors.dart';
import 'package:timers/utils/size_config.dart';

final TextEditingController workoutTimeController = TextEditingController();
final TextEditingController restTimeController = TextEditingController();
final TextEditingController runsController = TextEditingController();

void showEditTimerBottomSheet(
    BuildContext context, IsarDb db, WorkoutTimer workoutTimer) {
  Map<int, TextEditingController> textEditingControllers = {};

  void setupTextEditingControllers() {
    for (var i = 0; i < workoutTimer.runs; i++) {
      textEditingControllers.putIfAbsent(i, () => TextEditingController());
    }
  }

  WorkoutTimer getUpdatedTimer() {
    List<int> durations = [];
    for (var i = 0; i < workoutTimer.runs; i++) {
      if (textEditingControllers[i]?.text != null) {
        durations.add(int.parse(textEditingControllers[i]!.text));
      }
    }
    workoutTimer.workoutDurations = durations;
    return workoutTimer;
  }

  showModalBottomSheet(
      useRootNavigator: true,
      isScrollControlled: true,
      showDragHandle: true,
      context: context,
      builder: (context) {
        setupTextEditingControllers();
        return Padding(
          padding: EdgeInsets.only(
              left: SizeConfig.blockSizeHorizontal * 2,
              right: SizeConfig.blockSizeHorizontal * 2,
              bottom: (MediaQuery.of(context).viewInsets.bottom) +
                  SizeConfig.blockSizeVertical * 3),
          child: SingleChildScrollView(
            child: SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (var i = 0; i < workoutTimer.runs; i++)
                    editWorkoutCountdownTextField(textEditingControllers, i),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.blockSizeHorizontal * 2,
                        vertical: SizeConfig.blockSizeVertical * 2),
                    child: MainButton(
                        text: "Save Workout",
                        callback: () {
                          db.saveWorkout(getUpdatedTimer());
                          Navigator.pop(context);
                        }),
                  )
                ],
              ),
            ),
          ),
        );
      });
}

Widget editWorkoutCountdownTextField(
    Map<int, TextEditingController> textEditingControllers, int i) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Padding(
          padding:
              EdgeInsets.symmetric(vertical: SizeConfig.blockSizeVertical)),
      CupertinoTextField(
        padding: EdgeInsets.symmetric(
            vertical: SizeConfig.blockSizeVertical * 2,
            horizontal: SizeConfig.blockSizeHorizontal * 2),
        controller: textEditingControllers[i],
        placeholder: "Workout $i countdown",
        placeholderStyle:
            const TextStyle(color: AppColors.lightBackgroundColor),
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly
        ], // Only numbers can be entered
      ),
    ],
  );
}
