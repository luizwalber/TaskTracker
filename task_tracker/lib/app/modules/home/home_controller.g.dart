// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeController on _HomeControllerBase, Store {
  Computed<Map<String, List<Task>>> _$monthlyTasksComputed;

  @override
  Map<String, List<Task>> get monthlyTasks => (_$monthlyTasksComputed ??=
          Computed<Map<String, List<Task>>>(() => super.monthlyTasks,
              name: '_HomeControllerBase.monthlyTasks'))
      .value;
  Computed<List<Task>> _$selectedTasksComputed;

  @override
  List<Task> get selectedTasks => (_$selectedTasksComputed ??=
          Computed<List<Task>>(() => super.selectedTasks,
              name: '_HomeControllerBase.selectedTasks'))
      .value;

  final _$selectedDayAtom = Atom(name: '_HomeControllerBase.selectedDay');

  @override
  DateTime get selectedDay {
    _$selectedDayAtom.reportRead();
    return super.selectedDay;
  }

  @override
  set selectedDay(DateTime value) {
    _$selectedDayAtom.reportWrite(value, super.selectedDay, () {
      super.selectedDay = value;
    });
  }

  final _$taskListAtom = Atom(name: '_HomeControllerBase.taskList');

  @override
  ObservableStream<List<Task>> get taskList {
    _$taskListAtom.reportRead();
    return super.taskList;
  }

  @override
  set taskList(ObservableStream<List<Task>> value) {
    _$taskListAtom.reportWrite(value, super.taskList, () {
      super.taskList = value;
    });
  }

  final _$_HomeControllerBaseActionController =
      ActionController(name: '_HomeControllerBase');

  @override
  void setTasks(DateTime day) {
    final _$actionInfo = _$_HomeControllerBaseActionController.startAction(
        name: '_HomeControllerBase.getTasks');
    try {
      return super.setTasks(day);
    } finally {
      _$_HomeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic changeSelectedDay(DateTime newDay) {
    final _$actionInfo = _$_HomeControllerBaseActionController.startAction(
        name: '_HomeControllerBase.changeSelectedDay');
    try {
      return super.changeSelectedDay(newDay);
    } finally {
      _$_HomeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
selectedDay: ${selectedDay},
taskList: ${taskList},
monthlyTasks: ${monthlyTasks},
selectedTasks: ${selectedTasks}
    ''';
  }
}
