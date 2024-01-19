import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import 'package:flutter_r5_app/features/home/home.dart';

@injectable
class UpdateStateTODOUseCase {
  UpdateStateTODOUseCase(this._taskRepository);

  final TaskRepository _taskRepository;

  Future<Either<FirebaseException, bool>> execute(
    String taskID,
    bool taskState,
  ) async {
    return await _taskRepository.updateStateTask(taskID, taskState);
  }
}
