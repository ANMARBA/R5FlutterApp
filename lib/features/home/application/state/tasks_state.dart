import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:flutter_r5_app/features/home/home.dart';

part 'tasks_state.freezed.dart';

@freezed
class TasksState with _$TasksState {
  // Empty constructor
  const TasksState._();

  const factory TasksState.initial() = _Initial;

  const factory TasksState.getTasks({
    @Default([]) List<ToDo> tasks,
    @Default(false) bool isLoading,
    FirebaseException? failure,
  }) = _GetTask;

  const factory TasksState.addTask({
    @Default(false) bool successful,
    @Default(false) bool isLoading,
    FirebaseException? failure,
  }) = _AddTask;
}
