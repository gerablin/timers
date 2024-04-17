import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:timers/components/buttons/main_button.dart';
import 'package:timers/components/db/isar_db.dart';
import 'package:timers/models/workout_timer.dart';
import 'package:timers/utils/app_colors.dart';
import 'package:timers/utils/size_config.dart';

class CreateTimerInputs extends StatefulWidget {
  const CreateTimerInputs({
    super.key,
    required this.workoutNameController,
    required this.workoutTimeController,
    required this.restTimeController,
    required this.runsController,
    required this.db,
  });

  final TextEditingController workoutNameController;
  final TextEditingController workoutTimeController;
  final TextEditingController restTimeController;
  final TextEditingController runsController;
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
        _Title(),
        // Workout time
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.blockSizeHorizontal * 2,
              vertical: SizeConfig.blockSizeVertical * 2),
          child: Column(
            children: [
              CupertinoTextField(
                  onChanged: (newValue) => setState(() {}),
                  padding: EdgeInsets.symmetric(
                      vertical: SizeConfig.blockSizeVertical * 2,
                      horizontal: SizeConfig.blockSizeHorizontal * 2),
                  controller: widget.workoutNameController,
                  placeholder: "Enter a name",
                  placeholderStyle:
                      TextStyle(color: AppColors.lightBackgroundColor),
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(30),
                  ]),
              Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: SizeConfig.blockSizeVertical)),

              CupertinoTextField(
                onChanged: (newValue) => setState(() {}),
                padding: EdgeInsets.symmetric(
                    vertical: SizeConfig.blockSizeVertical * 2,
                    horizontal: SizeConfig.blockSizeHorizontal * 2),
                controller: widget.workoutTimeController,
                placeholder: "Enter your workout time",
                placeholderStyle:
                    TextStyle(color: AppColors.lightBackgroundColor),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
              ),
              Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: SizeConfig.blockSizeVertical)),

              // rest time
              CupertinoTextField(
                onChanged: (newValue) => setState(() {}),
                padding: EdgeInsets.symmetric(
                    vertical: SizeConfig.blockSizeVertical * 2,
                    horizontal: SizeConfig.blockSizeHorizontal * 2),
                controller: widget.restTimeController,
                placeholder: "Enter your rest time",
                placeholderStyle:
                    TextStyle(color: AppColors.lightBackgroundColor),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ], // Only numbers can be entered
              ),
              Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: SizeConfig.blockSizeVertical)),

              // runs
              CupertinoTextField(
                onChanged: (newValue) => setState(() {}),
                padding: EdgeInsets.symmetric(
                    vertical: SizeConfig.blockSizeVertical * 2,
                    horizontal: SizeConfig.blockSizeHorizontal * 2),
                controller: widget.runsController,
                placeholder: "Enter your amount of runs",
                placeholderStyle:
                    TextStyle(color: AppColors.lightBackgroundColor),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ], // Only numbers can be entered
              ),
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
                  widget.db.saveWorkout(WorkoutTimer(
                      name: widget.workoutNameController.text,
                      workoutCountDown:
                          int.parse(widget.workoutTimeController.text),
                      restCountDown: int.parse(widget.restTimeController.text),
                      runs: int.parse(widget.runsController.text)));
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
        widget.runsController.text.isNotEmpty;
  }
}

class _Title extends StatelessWidget {
  const _Title({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: SizeConfig.blockSizeHorizontal * 2,
      ),
      child: Text(
        "New Timer",
        style: TextStyle(fontWeight: FontWeight.w700, fontSize: 24),
      ),
    );
  }
}
