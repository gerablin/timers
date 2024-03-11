import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:timers/components/db/isar_db.dart';
import 'package:timers/models/timer.dart';
import 'package:timers/screens/main_timer.dart';
import 'package:timers/screens/overview/overview_screen.dart';
import 'package:timers/utils/size_config.dart';

void main() {
  runApp( MyApp());
  initDatabaseHive();
  initDatabaseIsar();
}

Future<void> initDatabaseIsar() async {
  WorkoutTimer workoutTimer =
  WorkoutTimer(workoutCountDown: 3, restCountDown: 2, runs: 3);
  await IsarDb().cleanDb();
  await IsarDb().saveWorkout(workoutTimer);
}
Future<void> initDatabaseHive() async {
  // final directory = await getApplicationDocumentsDirectory();
  // await Hive..initFlutter(directory.path)..registerAdapter();
  await addDefaultWorkoutHive();
}

Future<void> addDefaultWorkoutHive() async {
  WorkoutTimer workoutTimer =
  WorkoutTimer(workoutCountDown: 3, restCountDown: 2, runs: 3);
  //
  // var workoutBox = await Hive.openBox('workout_timers');
  // workoutBox.clear();
  // workoutBox.add(workoutTimer);
  // print(workoutBox.get(0));
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
            path: 'timer/:initialCountdown',
            builder: (BuildContext context, GoRouterState state) {
              return MainTimer(
                  initialCountdown:
                      int.parse(state.pathParameters['initialCountdown']!));
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

class MyHomePage extends StatelessWidget {
   MyHomePage({super.key, required this.title});

  final String title;

  bool isPlaying = false;

  double progressValue = 1.0;

  final initialCountdown = 10;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Dein Timer"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 5),
              child: MainTimer(
                initialCountdown: initialCountdown,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
