import 'package:git_app/tudo_list_app/models/enum_states.dart';

class TasksModel {
  TasksModel({
    this.id = 0,
    required this.tittle,
    required this.description,
    required this.status,
  });

 
  Status status;
  String tittle;
  String description;
  int id;

  TasksModel copyWith({
    int? id,
    String? tittle,
    String? description,
    Status? status,
  }) {
    return TasksModel(
      id: id ?? this.id,
      tittle: tittle ?? this.tittle,
      description: description ?? this.description,
      status: status ?? this.status,
    );
  }

 // Converte o objeto para Map (JSON)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'tittle': tittle,
      'description': description,
      'status': status.toString().split('.').last, // Converte enum para String
    };
  }
  factory TasksModel.fromJson(Map<String, dynamic> json) {
    return TasksModel(
      id: json['id'] ?? 0,
      tittle: json['tittle'] ?? '',
      description: json['description'] ?? '',
      status: (json['status']),
    );
  }
}




