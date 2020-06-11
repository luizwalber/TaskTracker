// More advanced TableCalendar configuration (using Builders & Styles)
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:i18n_extension/i18n_widget.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:task_tracker/app/modules/home/home_controller.dart';
import 'package:task_tracker/app/shared/model/task.dart';
import 'package:task_tracker/app/shared/model/task_schema.dart';

class CalendarWidget extends StatefulWidget {
  CalendarWidget({Key key}) : super(key: key);

  @override
  _CalendarWidgetState createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget>
    with TickerProviderStateMixin {
  AnimationController _animationController;
  CalendarController _calendarController;

  @override
  void initState() {
    _calendarController = CalendarController();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _calendarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      rowHeight: 40,
      //TODO bug, is overflowing when the month has more than 4 weeks DIFERENT RESOLUTIONS DIFERENT ROW HEIGHTS
      locale: I18n.localeStr,
      calendarController: _calendarController,
      events: extractEvents(),
      calendarStyle: _calendarStyle(),
      headerStyle: _calendarHeaderStyle(),
      builders: calendarBuilders(),
      onVisibleDaysChanged: _onMonthChange,
    );
  }

  void _onMonthChange(DateTime first, DateTime last, CalendarFormat format) {
    // TaskService.instance //TODO
    //     .changeMonth(first.year, first.month, widget.taskSchemas);
  }

  CalendarBuilders calendarBuilders() {
    return CalendarBuilders(
      selectedDayBuilder: _onSelectDay,
      todayDayBuilder: _todayBuilder,
      markersBuilder: _markersBuilder,
      weekendDayBuilder: _weekendDayBuilder,
    );
  }

  List<Widget> _markersBuilder(context, date, tasks, holidays) {
    return _buildMarkers(tasks, date);
  }

  Widget _todayBuilder(context, date, _) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.grey[300],
        ),
        width: 100,
        height: 100,
        child: Center(
          child: Text(
            '${date.day}',
            style: TextStyle().copyWith(fontSize: 16.0),
          ),
        ),
      ),
    );
  }

  Widget _weekendDayBuilder(context, date, _) {
    return Center(
      child: Container(
        child: Center(
          child: Text(
            '${date.day}',
            style: TextStyle().copyWith(fontSize: 14.0),
          ),
        ),
      ),
    );
  }

  Widget _dayBuilder(context, date, _) {
    //TODO
    return Center(
      child: Container(
        child: Center(
          child: Text(
            '${date.day}',
            style: TextStyle().copyWith(fontSize: 14.0),
          ),
        ),
      ),
    );
  }

  Widget _onSelectDay(context, date, _) {
    Modular.get<HomeController>().changeSelectedDay(date);

    return FadeTransition(
        opacity: Tween(begin: 0.0, end: 1.0).animate(_animationController),
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.red[100],
            ),
            width: 100,
            height: 100,
            child: Center(
              child: Text(
                '${date.day}',
                style: TextStyle().copyWith(fontSize: 16.0),
              ),
            ),
          ),
        ));
  }

  HeaderStyle _calendarHeaderStyle() {
    return HeaderStyle(
      centerHeaderTitle: true,
      formatButtonVisible: false,
    );
  }

  CalendarStyle _calendarStyle() {
    return CalendarStyle(
        outsideDaysVisible: false,
        weekendStyle: TextStyle().copyWith(color: Colors.pinkAccent));
  }

  Map<DateTime, List<Task>> extractEvents() {
    Map<DateTime, List<Task>> events = {};
    Modular.get<HomeController>().monthlyTasks?.forEach((dayHash, tasks) {
      final DateTime date = DateTime.parse(dayHash);
      events[date] = tasks;
    });

    return events;
  }

  List<Widget> _buildMarkers(List tasks, DateTime date) {
    final children = <Widget>[];

    if (tasks.isNotEmpty) {
      // children.add(
      //   Positioned(
      //     right: 1,
      //     bottom: 1,
      //     child: _buildTaskCounter(date, tasks),
      //   ),
      // );
      children.add(
        Positioned.fill(
          child: Align(
              alignment: Alignment.bottomCenter,
              child: _buildTaskStatusFlag(date, tasks)),
        ),
      );
    }

    return children;
  }

  Widget _buildTaskCounter(DateTime date, List tasks) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: Colors.blue[400],
      ),
      width: 16.0,
      height: 16.0,
      child: Center(
        child: Text(
          '${tasks.length}',
          style: TextStyle().copyWith(
            color: Colors.white,
            fontSize: 12.0,
          ),
        ),
      ),
    );
  }

  Widget _buildTaskStatusFlag(DateTime date, List<Task> tasks) {
    int current = 0;
    List<Widget> circles = tasks
        .map((Task task) => _circleStatus(
            task.finished ? Colors.green : Colors.red, tasks.length, current++))
        .toList();

    return Row(
      children: circles,
      mainAxisAlignment: MainAxisAlignment.center,
    );
  }

  Widget _circleStatus(Color color, int count, current) {
    double size = 7;

    if (current > 7) {
      return Text('');
    }
    size = 10.0 - count;
    if (size <= 4) size = 4;

    return Padding(
      padding: const EdgeInsets.only(bottom: 3.0, left: 1),
      child: ClipOval(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          decoration: BoxDecoration(
              gradient:
                  LinearGradient(colors: [color, color.withOpacity(0.6)])),
          width: size,
          height: size,
        ),
      ),
    );
  }
}
