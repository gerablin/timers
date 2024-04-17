import 'package:flutter/material.dart';
import 'package:timers/screens/overview/components/create_timer_inputs.dart';
import 'package:timers/components/db/isar_db.dart';
import 'package:timers/utils/size_config.dart';

void showCreateTimerBottomSheet(BuildContext context, IsarDb db) {
  final TextEditingController workoutNameController = TextEditingController();
  final TextEditingController workoutTimeController = TextEditingController();
  final TextEditingController restTimeController = TextEditingController();
  final TextEditingController runsController = TextEditingController();

  showModalBottomSheet(
      useRootNavigator: true,
      isScrollControlled: true,
      showDragHandle: true,
      context: context,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
              left: SizeConfig.blockSizeHorizontal * 2,
              right: SizeConfig.blockSizeHorizontal * 2,
              bottom: (MediaQuery.of(context).viewInsets.bottom) +
                  SizeConfig.blockSizeVertical * 3),
          child: SizedBox(
            width: double.infinity,
            child: CreateTimerInputs(
              workoutNameController: workoutNameController,
                workoutTimeController: workoutTimeController,
                restTimeController: restTimeController,
                runsController: runsController,
                db: db),
          ),
        );
      });
}
