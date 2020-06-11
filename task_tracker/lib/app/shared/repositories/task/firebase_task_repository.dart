import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task_tracker/app/shared/model/task.dart';
import 'package:task_tracker/app/shared/repositories/task/task_repository_interface.dart';

class FirebaseTaskRepository implements ITaskRepository {
  final Firestore firestore;

  FirebaseTaskRepository(this.firestore);

  @override
  Future<void> create() {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  Future<void> delete() {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Stream<List<Task>> watchMonthlyTasks(DateTime date) {
    if (date == null) {
      return null; // TODO error
    }

    DateTime start = DateTime(date.year, date.month, 01);
    DateTime end;

    if (date.month == 12) {
      end = DateTime(date.year + 1, 1, 01).subtract(Duration(days: 1));
    } else {
      end = DateTime(date.year, date.month + 1, 01).subtract(Duration(days: 1));
    }

    return firestore
        .collection(Task.table)
        // .where("createdBy", isEqualTo: "")
        // .where("day", isGreaterThan: start.microsecondsSinceEpoch)
        // .where("day", isLessThanOrEqualTo: end.microsecondsSinceEpoch)
        .snapshots()
        .map((QuerySnapshot query) {
      return query.documents.map((DocumentSnapshot doc) {
        return Task.fromFirestore(doc);
      }).toList();
    });
  }

  @override
  Future<Task> update() {
    // TODO: implement update
    throw UnimplementedError();
  }
}
