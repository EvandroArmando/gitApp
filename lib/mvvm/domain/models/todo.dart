class Todo {
  final int id;
  final String name;
  Todo({required this.id, required this.name});

  factory Todo.fromjson(Map<String, dynamic> json) {
    return Todo(id: int.parse(json["id"]), name: json["name"]);
  }
 
  Todo.amor(String name): name  =name,id  = 1;
  
}
