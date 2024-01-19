import 'package:flutter_r5_app/features/home/home.dart';

extension MapperListToDoDTO on List<ToDoDTO> {
  /// List DTO to List of Entity
  List<ToDo> toDomain() {
    return map((e) => e.toDomain()).toList();
  }
}

extension MapperToDoDTO on ToDoDTO {
  /// DTO to Entity
  ToDo toDomain() => ToDo(
        id: id,
        title: title,
        description: description,
        state: state,
        date: date,
      );
}

extension MapperToDo on ToDo {
  /// [ToDo] (Domain) to [ToDoDTO] (Infrastructure)
  ToDoDTO toDTO() {
    return ToDoDTO(
      id: id,
      title: title,
      description: description,
      state: state,
      date: date,
    );
  }
}
