import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_state_task_state.freezed.dart';

@freezed
class UpdateStateTaskState with _$UpdateStateTaskState {
  // Empty constructor
  const UpdateStateTaskState._();

  const factory UpdateStateTaskState.initial() = _Initial;

  const factory UpdateStateTaskState.updateStateTask({
    @Default(false) bool successful,
    @Default(false) bool isLoading,
    FirebaseException? failure,
  }) = _UpdateStateTask;
}
