import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import 'package:flutter_r5_app/features/home/home.dart';

@injectable
class DeleteTODOUseCase {
  DeleteTODOUseCase(this._taskRepository);

  final TaskRepository _taskRepository;

  Future<Either<FirebaseException, bool>> execute(String taskID) async {
    return await _taskRepository.deleteTODO(taskID);
  }
}
