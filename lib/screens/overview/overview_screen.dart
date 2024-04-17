import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:timers/components/icons/cooldown_icon.dart';
import 'package:timers/components/icons/fire_icon.dart';
import 'package:timers/components/db/isar_db.dart';
import 'package:timers/screens/overview/components/workout_list.dart';
import 'package:timers/screens/overview/create_timer_bottom_sheet.dart';
import 'package:timers/utils/size_config.dart';

import '../../models/workout_timer.dart';

class OverviewScreen extends StatefulWidget {
  OverviewScreen({super.key});

  @override
  State<OverviewScreen> createState() => _OverviewScreenState();
}

class _OverviewScreenState extends State<OverviewScreen> {
  final IsarDb db = IsarDb();

  bool isEditMode = false;

  void _openCreateTimerSheet(
    BuildContext context,
  ) {
    showCreateTimerBottomSheet(context, db);
  }

  void _toggleEditMode() {
    setState(() {
      isEditMode = !isEditMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Workouts"),
        actions: [
          IconButton(
            icon: isEditMode ? Icon(Icons.check_circle) : Icon(Icons.edit),
            // Use the edit icon
            onPressed: () {
              _toggleEditMode();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 2),
          child: Column(
            children: [
              WorkoutList(
                db: db,
                isEditMode: isEditMode,
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openCreateTimerSheet(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
