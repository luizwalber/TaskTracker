import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task_tracker/app/modules/home/widgets/task_list/task_list_controller.dart';
import 'package:task_tracker/app/modules/home/home_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:task_tracker/app/modules/home/home_page.dart';
import 'package:task_tracker/app/modules/home/widgets/calendar/calendar_controller.dart';
import 'package:task_tracker/app/shared/repositories/task/firebase_task_repository.dart';
import 'package:task_tracker/app/shared/repositories/task/task_repository_interface.dart';

class HomeModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => HomeController(i.get())),
        Bind((i) => TaskListController()),
        Bind((i) => CalendarController()),
        Bind<ITaskRepository>(
            (i) => FirebaseTaskRepository(Firestore.instance)),
      ];

  @override
  List<Router> get routers => [
        Router(Modular.initialRoute, child: (_, args) => HomePage()),
      ];

  static Inject get to => Inject<HomeModule>.of();
}
