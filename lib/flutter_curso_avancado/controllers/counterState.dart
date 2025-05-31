import 'package:git_app/flutter_curso_avancado/controllers/changeState.dart';

class CounterState extends ChangeState {
int count = 0;

void increment() {
  count++;
  notifyCallback();
}




}