import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timers/components/db/isar_db.dart';
import 'package:timers/screens/overview/components/app_drawer.dart';
import 'package:timers/screens/overview/components/workout_list.dart';
import 'package:timers/screens/overview/create_timer_bottom_sheet.dart';
import 'package:timers/utils/app_colors.dart';
import 'package:timers/utils/size_config.dart';

class OverviewScreen extends StatefulWidget {
  OverviewScreen({super.key});

  @override
  State<OverviewScreen> createState() => _OverviewScreenState();
}

class _OverviewScreenState extends State<OverviewScreen>
    with SingleTickerProviderStateMixin {
  final IsarDb db = IsarDb();
  late AnimationController _animationController;
  bool isPlaying = false;
  bool isDrawerOpen = false;
  bool isEditMode = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _openCreateTimerSheet(
    BuildContext context,
  ) {
    showCreateTimerBottomSheet(context, db);
  }

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    super.initState();
  }

  void _onDrawerChanged() {
    isPlaying = !isPlaying;
    setState(() {
      isDrawerOpen = !isDrawerOpen;
    });
    isPlaying ? _animationController.forward() : _animationController.reverse();
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
        leading: IconButton(
          icon: AnimatedIcon(
            icon: AnimatedIcons.menu_close,
            progress: _animationController,
          ),
          onPressed: () {
            if (!isDrawerOpen) {
              _scaffoldKey.currentState?.openDrawer();
            } else {
              Navigator.pop(context);
            }
          },
        ),
        actions: [
          IconButton(
            icon: isEditMode
                ? const Icon(Icons.check_circle)
                : const Icon(Icons.edit),
            // Use the edit icon
            onPressed: () {
              _toggleEditMode();
            },
          ),
        ],
      ),
      body: Scaffold(
        key: _scaffoldKey,
        onDrawerChanged: (onDrawerChanged) {
          _onDrawerChanged();
        },
        drawer: const AppDrawer(),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 2),
            child: Column(
              children: [
                WorkoutList(
                  db: db,
                  isEditMode: isEditMode,
                  onWorkoutClicked: _toggleEditMode,
                )
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openCreateTimerSheet(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }
}