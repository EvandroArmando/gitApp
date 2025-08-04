import 'package:freezed_annotation/freezed_annotation.dart';

part 'todo_api_model.freezed.dart';
part 'todo_api_model.g.dart';

@freezed
class TodoApiModel with _$TodoApiModel {
  const factory TodoApiModel.create({required String name}) =
      CreatedTodoApiModel;

  factory TodoApiModel.fromJson(Map<String, Object?> json) =>
      _$TodoApiModelFromJson(json);
}
