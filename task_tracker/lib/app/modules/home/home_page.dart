import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:task_tracker/app/modules/home/widgets/calendar/calendar_widget.dart';
import 'package:task_tracker/app/modules/home/widgets/task_list/task_list_widget.dart';
import 'package:task_tracker/app/shared/date_utils.dart';
import 'package:task_tracker/app/shared/model/task.dart';
import 'home_controller.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key key, this.title = "Home"}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeController> {
  //use 'controller' variable to access controller

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      // body: _buildBody(),

      body: Column(
        children: [
          _buildCalendar(),
          // _buildTaskList(),
        ],
      ),
    );
  }

  Widget _buildBody() {
    return Observer(builder: (_) {
      ObservableStream result = controller.taskList;
      List<Task> selectedTasks = controller.selectedTasks;

      if (result.hasError) {
        //TODO
        return Container();
      }

      if (result.data == null) {
        return Center(child: CircularProgressIndicator());
      }

      if (selectedTasks == null) {
        return Center(child: CircularProgressIndicator());
      }

      return Column(
        children: [
          CalendarWidget(
              // monthlyTasks: controller.groupTasksByMonth(result.data),
              ),
          Expanded(
            child: TaskListWidget(
              selectedTasks: selectedTasks,
            ),
          ),
        ],
      );
    });
  }

  Widget _buildCalendar() {
    return CalendarWidget();
  }

  Widget _buildTaskList() {
    return Observer(builder: (_) {
      List<Task> result = controller.selectedTasks;

      if (result == null) {
        return Center(child: CircularProgressIndicator());
      }

      return TaskListWidget(
        selectedTasks: result,
      );
    });
  }
}
