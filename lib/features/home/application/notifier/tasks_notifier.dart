import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_r5_app/features/home/home.dart';

class GetTaskNotifier extends StateNotifier<TasksState> {
  GetTaskNotifier(
    this._getTODOsUseCase,
    this._addTODOUseCase,
  ) : super(const TasksState.initial());

  final GetTODOsUseCase _getTODOsUseCase;
  final AddTODOUseCase _addTODOUseCase;

  Future<void> getTODOs() async {
    state = const TasksState.getTasks(isLoading: true);

    final fold = await _getTODOsUseCase.execute();
    state = fold.fold(
      (failure) => TasksState.getTasks(failure: failure),
      (tasks) => TasksState.getTasks(tasks: tasks),
    );
  }

  Future<void> addTODO(AddTODOParams params) async {
    state = const TasksState.addTask(isLoading: true);
    final fold = await _addTODOUseCase.execute(params);
    state = fold.fold(
      (failure) => TasksState.addTask(failure: failure),
      (successful) => TasksState.addTask(successful: successful),
    );
  }
}
