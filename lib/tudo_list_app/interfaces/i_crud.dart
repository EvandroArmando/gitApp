import 'package:git_app/tudo_list_app/models/tasks.dart';

abstract  class ICrud {
  void create(TasksModel task);

  void delete(int id);

  void update(int id);
  
  void getAll( );
}
