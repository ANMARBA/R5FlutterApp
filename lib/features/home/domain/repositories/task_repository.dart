import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

import 'package:flutter_r5_app/features/home/home.dart';

abstract class TaskRepository {
  Future<Either<FirebaseException, List<ToDo>>> getTODOs();
  Future<Either<FirebaseException, bool>> addTODO(ToDo task);
  Future<Either<FirebaseException, bool>> deleteTODO(String taskID);
  Future<Either<FirebaseException, bool>> updateStateTask(
      String taskID, bool taskState);
}
