import 'package:isar/isar.dart';

part 'workout_timer.g.dart';

@collection
class WorkoutTimer {
  Id id = Isar.autoIncrement; // you can also use id = null to auto increment

  String name;
  int restCountDown;
  int workoutCountDown;
  int runs;
  List<int> workoutDurations;

  WorkoutTimer({
    required this.name,
    required this.workoutCountDown,
    required this.restCountDown,
    required this.runs,
    this.workoutDurations = const [], // Optional parameter
  });
}

extension CountdownListExtension on WorkoutTimer {
  // Pair of Countdown and if it is a rest timer
  List<Pair<int, bool>> generateCountdowns() {
    List<Pair<int, bool>> countdowns = [];

    if(workoutDurations.isEmpty){
    // if workout durations are all the same and not individualised
      addByWorkoutCountdown(countdowns);
    } else {
      // if individual durations are given
      addByIndividualDuration(countdowns);
    }
    return countdowns;
  }

  void addByIndividualDuration(List<Pair<int, bool>> countdowns) {

    // Add the initial workout countdown
    countdowns.add(Pair<int, bool>(workoutDurations[0], false));

    // Add rest countdowns and workout countdowns based on runs
    for (int i = 1; i < runs; i++) {
      countdowns.add(Pair<int, bool>(restCountDown, true));
      countdowns.add(Pair<int, bool>(workoutDurations[i], false));
    }
  }

  void addByWorkoutCountdown(List<Pair<int, bool>> countdowns) {
      // Add the initial workout countdown
    countdowns.add(Pair<int, bool>(workoutCountDown, false));

    // Add rest countdowns based on runs
    for (int i = 1; i < runs; i++) {
      countdowns.add(Pair<int, bool>(restCountDown, true));
      countdowns.add(Pair<int, bool>(workoutCountDown, false));
    }
  }
}

class Pair<T1, T2> {
  final T1 first;
  final T2 second;

  Pair(this.first, this.second);
}
