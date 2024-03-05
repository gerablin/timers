class WorkoutTimer {
  final int restCountDown;
  final int workoutCountDown;
  final int runs;

  WorkoutTimer(
      {required this.workoutCountDown,
      required this.restCountDown,
      required this.runs});

}
extension CountdownListExtension on WorkoutTimer {
  List<Pair<int, bool>> generateCountdowns() {
    List<Pair<int, bool>> countdowns = [];

    // Add the initial workout countdown
    countdowns.add(Pair<int, bool>(workoutCountDown, false));

    // Add rest countdowns based on runs
    for (int i = 1; i < runs; i++) {
      countdowns.add(Pair<int, bool>(restCountDown, true));
      countdowns.add(Pair<int, bool>(workoutCountDown, false));
    }

    // Add the last workout countdown
    countdowns.add(Pair<int, bool>(workoutCountDown, false));

    return countdowns;
  }
}

class Pair<T1, T2> {
  final T1 first;
  final T2 second;

  Pair(this.first, this.second);
}