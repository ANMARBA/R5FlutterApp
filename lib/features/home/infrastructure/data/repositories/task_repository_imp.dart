import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import 'package:flutter_r5_app/features/home/home.dart';

/// Implementation of [TaskRepository]
@Injectable(as: TaskRepository)
class TaskRepositoryImp implements TaskRepository {
  /// Constructor
  TaskRepositoryImp(
    this._taskRemoteService,
  );

  final TaskRemoteService _taskRemoteService;

  @override
  Future<Either<FirebaseException, List<ToDo>>> getTODOs() async {
    final response = await _taskRemoteService.getTODOs();
    return Right(response.toDomain());
  }

  @override
  Future<Either<FirebaseException, bool>> addTODO(ToDo task) async {
    final response = await _taskRemoteService.addTODO(task.toDTO());
    return Right(response);
  }

  @override
  Future<Either<FirebaseException, bool>> deleteTODO(String taskID) async {
    final response = await _taskRemoteService.deleteTODO(taskID);
    return Right(response);
  }

  @override
  Future<Either<FirebaseException, bool>> updateStateTask(
    String taskID,
    bool taskState,
  ) async {
    final response = await _taskRemoteService.updateStateTask(
      taskID,
      taskState,
    );
    return Right(response);
  }
}
