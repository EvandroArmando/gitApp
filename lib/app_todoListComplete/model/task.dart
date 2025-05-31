class TaskNewModel {
  TaskNewModel({required this.title, required this.description});

  String title;
  String description;

  TaskNewModel copyWith({String? title, String? description}) {
    return TaskNewModel(
      title: title ?? this.title,
      description: description ?? this.description,
    );
  }
}
