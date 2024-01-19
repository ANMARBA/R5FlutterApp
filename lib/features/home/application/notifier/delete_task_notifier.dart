import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_r5_app/features/home/home.dart';

class DeleteTaskNotifier extends StateNotifier<DeleteTaskState> {
  DeleteTaskNotifier(
    this._deleteTODOUseCase,
  ) : super(const DeleteTaskState.initial());

  final DeleteTODOUseCase _deleteTODOUseCase;

  Future<void> deleteTODO(String taskID) async {
    state = const DeleteTaskState.deleteTask(isLoading: true);
    final fold = await _deleteTODOUseCase.execute(taskID);
    fold.fold(
      (failure) => state = DeleteTaskState.deleteTask(failure: failure),
      (successful) =>
          state = DeleteTaskState.deleteTask(successful: successful),
    );
  }
}
