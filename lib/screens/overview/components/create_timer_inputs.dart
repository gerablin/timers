import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:timers/components/buttons/main_button.dart';
import 'package:timers/components/db/isar_db.dart';
import 'package:timers/components/icons/cooldown_icon.dart';
import 'package:timers/components/icons/fire_icon.dart';
import 'package:timers/components/icons/runs_icon.dart';
import 'package:timers/components/text/bottom_sheet_title.dart';
import 'package:timers/components/text_fields/session_inputs.dart';
import 'package:timers/models/workout_timer.dart';
import 'package:timers/utils/app_colors.dart';
import 'package:timers/utils/size_config.dart';
import 'package:timers/utils/strings.dart' as Strings;


class CreateTimerInputs extends StatefulWidget {
  const CreateTimerInputs({
    super.key,
    required this.workoutNameController,
    required this.workoutTimeController,
    required this.restTimeController,
    required this.runsController,
    required this.sessionController,
    required this.sessionCooldownController,
    required this.db,
  });

  final TextEditingController workoutNameController;
  final TextEditingController workoutTimeController;
  final TextEditingController restTimeController;
  final TextEditingController runsController;
  final TextEditingController sessionController;
  final TextEditingController sessionCooldownController;
  final IsarDb db;

  @override
  State<CreateTimerInputs> createState() => _CreateTimerInputsState();
}

class _CreateTimerInputsState extends State<CreateTimerInputs> {
  @override
  void dispose() {
    widget.workoutNameController.dispose();
    widget.workoutTimeController.dispose();
    widget.restTimeController.dispose();
    widget.runsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const BottomSheetTitle(title: "Create Timer"),
        // Workout time
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.blockSizeHorizontal * 2,
              vertical: SizeConfig.blockSizeVertical * 2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // name
              CupertinoTextField(
                  onChanged: (newValue) => setState(() {}),
                  padding: EdgeInsets.symmetric(
                      vertical: SizeConfig.blockSizeVertical * 2,
                      horizontal: SizeConfig.blockSizeHorizontal * 2),
                  controller: widget.workoutNameController,
                  placeholder: "Name",
                  placeholderStyle:
                      const TextStyle(color: AppColors.inputPlaceholderColor),
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(30),
                  ]),
              Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: SizeConfig.blockSizeVertical)),

              // workout time
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
                      controller: widget.workoutTimeController,
                      placeholder: "Workout time in seconds",
                      placeholderStyle:
                          const TextStyle(color: AppColors.inputPlaceholderColor),
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: SizeConfig.blockSizeVertical)),

              // rest time
              Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(right: 8.0),
                    child: CooldownIcon(),
                  ),
                  Flexible(
                    child: CupertinoTextField(
                      onChanged: (newValue) => setState(() {}),
                      padding: EdgeInsets.symmetric(
                          vertical: SizeConfig.blockSizeVertical * 2,
                          horizontal: SizeConfig.blockSizeHorizontal * 2),
                      controller: widget.restTimeController,
                      placeholder: "Rest time in seconds",
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
              Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: SizeConfig.blockSizeVertical)),

              // runs
              Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(right: 8.0),
                    child: RunsIcon(),
                  ),
                  Flexible(
                    child: CupertinoTextField(
                      onChanged: (newValue) => setState(() {}),
                      padding: EdgeInsets.symmetric(
                          vertical: SizeConfig.blockSizeVertical * 2,
                          horizontal: SizeConfig.blockSizeHorizontal * 2),
                      controller: widget.runsController,
                      placeholder: "Amount of runs",
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
              Padding(
                padding: EdgeInsets.only(
                  left: SizeConfig.blockSizeHorizontal * 2,
                  right: SizeConfig.blockSizeHorizontal * 2,
                  top: SizeConfig.blockSizeVertical * 2
                ),
                child: const BottomSheetSubtitle(text: Strings.sessionSubtitle),
              ),
              SessionInputs(
                  sessionTextEditingController: widget.sessionController,
                  sessionCooldownTextEditingController:
                      widget.sessionCooldownController,
                  onChanged: (newValue) => setState(() {}))
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.blockSizeHorizontal * 2),
          child: MainButton(
              text: "Create Workout",
              isEnabled: areAllFieldsFilled(),
              callback: () {
                if (areAllFieldsFilled()) {
                  widget.db.saveWorkout(
                    WorkoutTimer(
                        name: widget.workoutNameController.text,
                        workoutCountDown:
                            int.parse(widget.workoutTimeController.text),
                        restCountDown:
                            int.parse(widget.restTimeController.text),
                        runs: int.parse(
                          widget.runsController.text,
                        ),
                        sessions: int.tryParse(widget.sessionController.text),
                        sessionCooldownTime: int.tryParse(
                            widget.sessionCooldownController.text)),
                  );
                  Navigator.pop(context);
                }
              }),
        )
      ],
    );
  }

  bool areAllFieldsFilled() {
    return widget.workoutNameController.text.isNotEmpty &&
        widget.workoutTimeController.text.isNotEmpty &&
        widget.restTimeController.text.isNotEmpty &&
        widget.runsController.text.isNotEmpty &&
        widget.sessionController.text.isNotEmpty &&
        widget.sessionCooldownController.text.isNotEmpty;
  }
}
