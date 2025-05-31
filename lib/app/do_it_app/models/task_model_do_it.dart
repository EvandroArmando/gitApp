import 'package:hive/hive.dart';

part 'task_model_do_it.g.dart'; 

@HiveType(typeId: 0)
enum TaskStatus {
  @HiveField(0)
  pending,
  @HiveField(1)
  completed,
  @HiveField(2)
  inProgress,
}

@HiveType(typeId: 1)
class TaskModelDoIt extends HiveObject {
  @HiveField(0)
  final String title;

  @HiveField(1)
  final String description;

  @HiveField(2)
  final TaskStatus status;

  TaskModelDoIt({
    required this.title,
    required this.description,
    this.status = TaskStatus.pending,
  });
}
