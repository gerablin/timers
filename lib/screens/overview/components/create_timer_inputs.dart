import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:timers/components/buttons/main_button.dart';
import 'package:timers/components/db/isar_db.dart';
import 'package:timers/models/timer.dart';
import 'package:timers/utils/size_config.dart';

class CreateTimerInputs extends StatefulWidget {
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
  State<CreateTimerInputs> createState() => _CreateTimerInputsState();
}

class _CreateTimerInputsState extends State<CreateTimerInputs> {
  @override
  void dispose() {
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
        Text("New Timer"),
        // Workout time
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.blockSizeHorizontal * 2,
              vertical: SizeConfig.blockSizeVertical * 2),
          child: Column(
            children: [
              TextField(
                controller: widget.workoutTimeController,
                decoration:
                    InputDecoration(labelText: "Enter your workout time"),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ], // Only numbers can be entered
              ),
              // rest time
              TextField(
                controller: widget.restTimeController,
                decoration: InputDecoration(labelText: "Enter your rest time"),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ], // Only numbers can be entered
              ),
              // runs
              TextField(
                controller: widget.runsController,
                decoration: new InputDecoration(labelText: "Enter your runs"),
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
              callback: () {
                if (widget.workoutTimeController.text.isNotEmpty &&
                    widget.restTimeController.text.isNotEmpty &&
                    widget.runsController.text.isNotEmpty) {
                  widget.db.saveWorkout(WorkoutTimer(
                      workoutCountDown:
                          int.parse(widget.workoutTimeController.text),
                      restCountDown: int.parse(widget.restTimeController.text),
                      runs: int.parse(widget.runsController.text)));
                  Navigator.pop(context);
                } else {
                  //TODO: show error in sheet
                }
              }),
        )
      ],
    );
  }
}
