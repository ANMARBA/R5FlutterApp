import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_r5_app/features/home/home.dart';

class UpdateTaskNotifier extends StateNotifier<UpdateStateTaskState> {
  UpdateTaskNotifier(
    this._updateStateTODOUseCase,
  ) : super(const UpdateStateTaskState.initial());

  final UpdateStateTODOUseCase _updateStateTODOUseCase;

  Future<void> updateStateTODO(String taskID, bool taskState) async {
    state = const UpdateStateTaskState.updateStateTask(isLoading: true);
    final fold = await _updateStateTODOUseCase.execute(taskID, taskState);
    state = fold.fold(
      (failure) => UpdateStateTaskState.updateStateTask(failure: failure),
      (successful) =>
          UpdateStateTaskState.updateStateTask(successful: successful),
    );
  }
}
