import 'package:mobx/mobx.dart';

part 'task_list_controller.g.dart';

class TaskListController = _TaskListControllerBase with _$TaskListController;

abstract class _TaskListControllerBase with Store {}
