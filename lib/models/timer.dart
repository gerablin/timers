


import 'package:isar/isar.dart';

part 'timer.g.dart';

@collection
class WorkoutTimer {
  Id id = Isar.autoIncrement; // you can also use id = null to auto increment

  int restCountDown;
  int workoutCountDown;
  int runs;

  WorkoutTimer(
      {required this.workoutCountDown,
      required this.restCountDown,
      required this.runs});
}

extension CountdownListExtension on WorkoutTimer {
  // Pair of Countdown and if it is a rest timer
  List<Pair<int, bool>> generateCountdowns() {
    List<Pair<int, bool>> countdowns = [];

    // Add the initial workout countdown
    countdowns.add(Pair<int, bool>(workoutCountDown, false));

    // Add rest countdowns based on runs
    for (int i = 1; i < runs; i++) {
      countdowns.add(Pair<int, bool>(restCountDown, true));
      countdowns.add(Pair<int, bool>(workoutCountDown, false));
    }
    return countdowns;
  }
}

class Pair<T1, T2> {
  final T1 first;
  final T2 second;

  Pair(this.first, this.second);
}
