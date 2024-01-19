import 'package:freezed_annotation/freezed_annotation.dart';

part 'todo.freezed.dart';

@freezed
class ToDo with _$ToDo {
  // Empty constructor
  const ToDo._();

  const factory ToDo({
    @Default('') String id,
    required String title,
    required String description,
    required bool state,
    required DateTime date,
  }) = _ToDo;
}
