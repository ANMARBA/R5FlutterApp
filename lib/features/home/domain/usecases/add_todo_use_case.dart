import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import 'package:flutter_r5_app/features/home/home.dart';

@injectable
class AddTODOUseCase {
  AddTODOUseCase(this._taskRepository);

  final TaskRepository _taskRepository;

  Future<Either<FirebaseException, bool>> execute(AddTODOParams params) async {
    final taks = ToDo(
      title: params.title,
      description: params.description,
      state: params.state,
      date: params.date,
    );
    return await _taskRepository.addTODO(taks);
  }
}

/// Params for execute method on [AddTODOUseCase]
class AddTODOParams {
  /// Constructor
  const AddTODOParams({
    required this.title,
    required this.description,
    required this.state,
    required this.date,
  });

  final String title;
  final String description;
  final bool state;
  final DateTime date;
}
