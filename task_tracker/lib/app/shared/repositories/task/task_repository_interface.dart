import 'package:task_tracker/app/shared/model/task.dart';

abstract class ITaskRepository {
  Future<void> create();
  Future<Task> update();
  Stream<List<Task>> watchMonthlyTasks(DateTime day);
  Future<void> delete();
}
