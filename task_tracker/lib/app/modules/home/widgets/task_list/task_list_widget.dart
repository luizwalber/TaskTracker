import 'package:circular_check_box/circular_check_box.dart';
import 'package:flutter/material.dart';
import 'package:task_tracker/app/shared/date_utils.dart';
import 'package:task_tracker/app/shared/model/task.dart';

class TaskListWidget extends StatelessWidget {
  final List<Task> selectedTasks;

  TaskListWidget({Key key, this.selectedTasks});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue[500], Colors.blue[200]],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
      child: SingleChildScrollView(
        child: Column(children: <Widget>[
          _buildDate(context, selectedTasks),
          _buildTaskList(context),
        ]),
      ),
    );
  }

  Widget _buildDate(BuildContext context, List<Task> selectedTasks) {
    if (selectedTasks == null) {
      //TODO
    }
    DateTime selectedDay = selectedTasks[0].day;
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        Text(
          '${selectedDay.day}',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontSize: 50),
        ),
        Text(
          formatDate(context, selectedDay, 'MMM yyyy'),
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }

  Widget _buildTaskList(BuildContext context) {
    if (selectedTasks == null || selectedTasks.length == 0) {
      // TODO empty
      return Container(
        child: Text(
          'a',
          style: TextStyle(color: Colors.red),
        ),
        width: MediaQuery.of(context).size.width,
      );
    }

    selectedTasks
        .sort((Task task1, Task task2) => task1.title.compareTo(task2.title));
    // List<Widget> tasks = widget.selectedTasks
    //     .map((Task task) => _taskItem(task, context))
    //     .toList();

    return Column(
      children:
          selectedTasks.map((Task task) => _taskItem(task, context)).toList(),
    );
  }

  Widget _taskItem(Task task, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircularCheckBox(
          activeColor: Colors.white,
          checkColor: Colors.blue,
          inactiveColor: Colors.white,
          value: task.finished,
          onChanged: (bool newValue) => _changeTaskStatus(task, newValue),
        ),
        Text(
          '${task.title}',
          style: TextStyle(color: Colors.white),
        ),
      ],
    );
  }

  void _changeTaskStatus(Task task, bool finished) {
    task.finished = finished;
    // TaskService.instance.updateTask(task);TODO
  }
}
