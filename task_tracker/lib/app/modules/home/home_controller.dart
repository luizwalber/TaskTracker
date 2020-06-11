import 'package:mobx/mobx.dart';
import 'package:task_tracker/app/shared/date_utils.dart';
import 'package:task_tracker/app/shared/model/task.dart';
import 'package:collection/collection.dart';
import 'package:task_tracker/app/shared/repositories/task/task_repository_interface.dart';

part 'home_controller.g.dart';

class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  final ITaskRepository taskRepository;

  @observable
  DateTime selectedDay;
  @observable
  ObservableStream<List<Task>> taskList;

  @computed
  Map<String, List<Task>> get monthlyTasks {
    if (taskList.value == null) return null;
    return _groupTasksByMonth(taskList.value);
  }

  @computed
  List<Task> get selectedTasks {
    if (taskList.value == null) return null;
    return _groupTasksByMonth(taskList.value)[dateDayHash(selectedDay)];
  }

  _HomeControllerBase(this.taskRepository) {
    setTasks(DateTime.now());
    selectedDay = DateTime.now();
  }

  @action
  void setTasks(DateTime day) {
    taskList = taskRepository.watchMonthlyTasks(day).asObservable();
  }

  @action
  changeSelectedDay(DateTime newDay) {
    selectedDay = newDay;
  }

  Map<String, List<Task>> _groupTasksByMonth(List<Task> tasks) {
    return groupBy(tasks, (task) => dateDayHash(task.day));
  }
}
