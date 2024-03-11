import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:timers/models/timer.dart';

class IsarDb {
  late Future<Isar> db;

  IsarDb() {
    db = openDB();
  }

  Future<void> saveWorkout(WorkoutTimer timer) async {
    final isar = await db;
    isar.writeTxn(() => isar.workoutTimers.put(timer));
  }

  Future<Isar> openDB() async {
    final dir = await getApplicationDocumentsDirectory();

    // no db instance available
    if (Isar.instanceNames.isEmpty) {
      return await Isar.open([WorkoutTimerSchema],
          directory: dir.path, inspector: true);
    }

    return Future.value(Isar.getInstance());
  }

  Stream<List<WorkoutTimer>> listenToWorkoutTimers() async* {
    final isar = await db;
    yield* isar.workoutTimers.where().watch(fireImmediately: true);
  }

  Future<List<WorkoutTimer>> getAllWorkoutTimers() async {
    final isar = await db;
    return isar.workoutTimers.where().findAll();
  }

  Future<void> cleanDb() async{
    final isar = await db;
    isar.writeTxn(() => isar.clear());
  }
}
