import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

import 'package:flutter_r5_app/core/core.dart';
import 'package:flutter_r5_app/features/home/home.dart';

abstract class TaskRemoteService {
  Future<List<ToDoDTO>> getTODOs();
  Future<bool> addTODO(ToDoDTO task);
  Future<bool> deleteTODO(String taskID);
  Future<bool> updateStateTask(String taskID, bool taskState);
}

/// Implementation of [TaskRemoteService]
@Injectable(as: TaskRemoteService)
class TabAwardsRemoteServiceImpl extends TaskRemoteService {
  @override
  Future<List<ToDoDTO>> getTODOs() async {
    List<ToDoDTO> tasks = [];
    final firestore = getIt.get<FirebaseFirestore>();

    final getTasks = await firestore
        .collection('task')
        .orderBy('date')
        .orderBy('state')
        .get();

    for (var element in getTasks.docs) {
      final task = element.data();
      tasks.add(
        ToDoDTO(
          id: element.id,
          title: task['title'],
          description: task['description'],
          state: task['state'],
          date: (task['date'] as Timestamp).toDate(),
        ),
      );
    }

    return tasks;
  }

  @override
  Future<bool> addTODO(ToDoDTO task) async {
    final firestore = getIt.get<FirebaseFirestore>();
    return await firestore
        .collection('task')
        .add({
          'date': Timestamp.fromDate(task.date),
          'description': task.description,
          'title': task.title,
          'state': task.state,
        })
        .then((value) => true)
        .catchError((error) => false);
  }

  @override
  Future<bool> deleteTODO(String taskID) async {
    final firestore = getIt.get<FirebaseFirestore>();
    return await firestore
        .collection('task')
        .doc(taskID)
        .delete()
        .then((value) => true)
        .catchError((error) => false);
  }

  @override
  Future<bool> updateStateTask(String taskID, bool taskState) async {
    final firestore = getIt.get<FirebaseFirestore>();
    return await firestore
        .collection('task')
        .doc(taskID)
        .update({'state': taskState})
        .then((value) => true)
        .catchError((error) => false);
  }
}
