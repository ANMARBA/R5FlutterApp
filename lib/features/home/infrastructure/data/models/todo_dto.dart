import 'package:freezed_annotation/freezed_annotation.dart';

part 'todo_dto.freezed.dart';
part 'todo_dto.g.dart';

@freezed
class ToDoDTO with _$ToDoDTO {
  /// Named constructor
  const factory ToDoDTO({
    required String id,
    required String title,
    required String description,
    required bool state,
    required DateTime date,
  }) = _ToDoDTO;

  /// Function to handle `fromJson` and `toJson`
  factory ToDoDTO.fromJson(Map<String, dynamic> json) =>
      _$ToDoDTOFromJson(json);
}
