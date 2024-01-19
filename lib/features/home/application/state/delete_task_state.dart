import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'delete_task_state.freezed.dart';

@freezed
class DeleteTaskState with _$DeleteTaskState {
  // Empty constructor
  const DeleteTaskState._();

  const factory DeleteTaskState.initial() = _Initial;

  const factory DeleteTaskState.deleteTask({
    @Default(false) bool successful,
    @Default(false) bool isLoading,
    FirebaseException? failure,
  }) = _DeleteTask;
}
