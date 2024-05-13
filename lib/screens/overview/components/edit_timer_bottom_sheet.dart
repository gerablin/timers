import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:timers/components/buttons/main_button.dart';
import 'package:timers/components/db/isar_db.dart';
import 'package:timers/components/icons/fire_icon.dart';
import 'package:timers/components/text/bottom_sheet_title.dart';
import 'package:timers/components/text_fields/session_inputs.dart';
import 'package:timers/models/workout_timer.dart';
import 'package:timers/utils/app_colors.dart';
import 'package:timers/utils/constants.dart';
import 'package:timers/utils/size_config.dart';
import 'package:timers/utils/strings.dart' as Strings;

void showEditTimerBottomSheet(
    BuildContext context, IsarDb db, WorkoutTimer workoutTimer) {
  Map<int, TextEditingController> textEditingControllers = {};

  void setupTextEditingControllers() {
    for (var i = 0; i < workoutTimer.runs; i++) {
      textEditingControllers.putIfAbsent(
          i,
          () => TextEditingController(
              text: _getCurrentWorkoutTime(workoutTimer, i)));
    }
    textEditingControllers.putIfAbsent(
        runCooldownTextEditingControllerKey,
        () =>
            TextEditingController(text: workoutTimer.restCountDown.toString()));

    // session text controllers
    textEditingControllers.putIfAbsent(sessionTextEditingControllerKey,
        () => TextEditingController(text: workoutTimer.sessions.toString()));
    textEditingControllers.putIfAbsent(
        sessionCooldownTextEditingControllerKey,
        () => TextEditingController(
            text: workoutTimer.sessionCooldownTime.toString()));
  }

  showModalBottomSheet(
      useRootNavigator: true,
      isScrollControlled: true,
      showDragHandle: true,
      context: context,
      builder: (context) {
        setupTextEditingControllers();
        return EditWorkoutInputs(
            textEditingControllers: textEditingControllers,
            workoutTimer: workoutTimer,
            db: db);
      });
}

String _getCurrentWorkoutTime(WorkoutTimer workoutTimer, int index) {
  // default workout countdown
  if (workoutTimer.workoutDurations.isEmpty) {
    return workoutTimer.workoutCountDown.toString();
  }
  //individual timers have been set
  else {
    return workoutTimer.workoutDurations[index].toString();
  }
}

class EditWorkoutInputs extends StatefulWidget {
  const EditWorkoutInputs(
      {super.key,
      required this.textEditingControllers,
      required this.workoutTimer,
      required this.db});

  final WorkoutTimer workoutTimer;
  final IsarDb db;
  final Map<int, TextEditingController> textEditingControllers;

  @override
  State<EditWorkoutInputs> createState() => _EditWorkoutInputsState();
}

class _EditWorkoutInputsState extends State<EditWorkoutInputs> {
  WorkoutTimer getUpdatedTimer() {
    List<int> durations = [];
    for (var i = 0; i < widget.workoutTimer.runs; i++) {
      if (widget.textEditingControllers[i]?.text != null) {
        durations.add(int.parse(widget.textEditingControllers[i]!.text));
      }
    }
    widget.workoutTimer.workoutDurations = durations;
    widget.workoutTimer.sessions = int.tryParse(
        widget.textEditingControllers[sessionTextEditingControllerKey]?.text ??
            "");
    widget.workoutTimer.sessionCooldownTime = int.tryParse(widget
            .textEditingControllers[sessionCooldownTextEditingControllerKey]
            ?.text ??
        "");
    widget.workoutTimer.restCountDown = int.parse(widget
        .textEditingControllers[runCooldownTextEditingControllerKey]!.text);
    return widget.workoutTimer;
  }

  bool isAnyTextFieldEmpty() {
    for (final controller in widget.textEditingControllers.values) {
      if (controller.text.isEmpty) {
        return true; // Found an empty text field
      }
    }
    return false; // No empty text fields found
  }

  @override
  Widget build(BuildContext context) {
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
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const BottomSheetTitle(title: "Edit workout time"),
              // Widgets for workout time
              for (var i = 0; i < widget.workoutTimer.runs; i++)
                editWorkoutCountdownTextField(widget.textEditingControllers, i,
                    (newValue) => setState(() {})),
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: SizeConfig.blockSizeVertical),
              ),
              Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(right: 8.0),
                    child: FireIcon(),
                  ),
                  Flexible(
                    child: CupertinoTextField(
                      onChanged: (newValue) => setState(() {}),
                      padding: EdgeInsets.symmetric(
                          vertical: SizeConfig.blockSizeVertical * 2,
                          horizontal: SizeConfig.blockSizeHorizontal * 2),
                      controller: widget.textEditingControllers[
                          runCooldownTextEditingControllerKey]!,
                      placeholder: "Rest time between workout",
                      placeholderStyle: const TextStyle(
                          color: AppColors.inputPlaceholderColor),
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ], // Only numbers can be entered
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: SizeConfig.blockSizeHorizontal * 2,
                    right: SizeConfig.blockSizeHorizontal * 2,
                    top: SizeConfig.blockSizeVertical * 2),
                child: const BottomSheetSubtitle(text: Strings.sessionSubtitle),
              ),
              SessionInputs(
                  sessionTextEditingController: widget
                      .textEditingControllers[sessionTextEditingControllerKey]!,
                  sessionCooldownTextEditingController:
                      widget.textEditingControllers[
                          sessionCooldownTextEditingControllerKey]!,
                  onChanged: (newValue) => setState(() {})),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.blockSizeHorizontal * 2,
                    vertical: SizeConfig.blockSizeVertical * 2),
                child: MainButton(
                    isEnabled: !isAnyTextFieldEmpty(),
                    text: Strings.saveWorkoutButton,
                    callback: () {
                      widget.db.saveWorkout(getUpdatedTimer());
                      Navigator.pop(context);
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget editWorkoutCountdownTextField(
    Map<int, TextEditingController> textEditingControllers,
    int i,
    Function(String) onChanged) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Padding(
        padding: EdgeInsets.symmetric(vertical: SizeConfig.blockSizeVertical),
      ),
      Row(
        children: [
          const Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: FireIcon(),
          ),
          Flexible(
            child: CupertinoTextField(
              onChanged: onChanged,
              padding: EdgeInsets.symmetric(
                  vertical: SizeConfig.blockSizeVertical * 2,
                  horizontal: SizeConfig.blockSizeHorizontal * 2),
              controller: textEditingControllers[i],
              placeholder: "Workout ${i + 1} Countdown",
              placeholderStyle:
                  const TextStyle(color: AppColors.inputPlaceholderColor),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ], // Only numbers can be entered
            ),
          ),
        ],
      ),
    ],
  );
}
