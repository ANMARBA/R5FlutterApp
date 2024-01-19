import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import 'package:flutter_r5_app/features/home/home.dart';

@injectable
class GetTODOsUseCase {
  GetTODOsUseCase(this._taskRepository);

  final TaskRepository _taskRepository;

  Future<Either<FirebaseException, List<ToDo>>> execute() async {
    return await _taskRepository.getTODOs();
  }
}
