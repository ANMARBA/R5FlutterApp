import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_r5_app/core/core.dart';
import 'package:flutter_r5_app/features/home/home.dart';

/// Tasks Notifier Provider
final tasksNotifierProvider =
    StateNotifierProvider<GetTaskNotifier, TasksState>(
  (ref) => GetTaskNotifier(
    getIt<GetTODOsUseCase>(),
    getIt<AddTODOUseCase>(),
  ),
);

/// Delete Task Notifier Provider
final deleteTaskNotifierProvider =
    StateNotifierProvider<DeleteTaskNotifier, DeleteTaskState>(
  (ref) => DeleteTaskNotifier(getIt<DeleteTODOUseCase>()),
);

/// Update State Task Notifier Provider
final updateStateTaskNotifierProvider =
    StateNotifierProvider<UpdateTaskNotifier, UpdateStateTaskState>(
  (ref) => UpdateTaskNotifier(getIt<UpdateStateTODOUseCase>()),
);
