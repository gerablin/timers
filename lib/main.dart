import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:timers/components/db/isar_db.dart';
import 'package:timers/models/timer.dart';
import 'package:timers/screens/main_timer.dart';
import 'package:timers/screens/overview/overview_screen.dart';
import 'package:timers/utils/size_config.dart';

void main() {
  runApp( MyApp());
  initDatabaseIsar();
}

Future<void> initDatabaseIsar() async {
  WorkoutTimer workoutTimer =
  WorkoutTimer(workoutCountDown: 5, restCountDown: 2, runs: 3);
  await IsarDb().cleanDb();
  await IsarDb().saveWorkout(workoutTimer);
}

late SizeConfig sizeConfig;

final GoRouter _router = GoRouter(routes: <RouteBase>[
  GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return OverviewScreen();
      },
      routes: <RouteBase>[
        GoRoute(
            path: 'timer/:id',
            builder: (BuildContext context, GoRouterState state) {
              return MainTimer(
                  workoutId:
                      int.parse(state.pathParameters['id']!));
            })
      ])
]);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    sizeConfig = SizeConfig();
    sizeConfig.init(context);
    return MaterialApp.router(
      routerConfig: _router,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}