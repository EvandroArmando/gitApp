import 'package:git_app/app/do_it_app/Interfaces/base_state.dart';

class BaseStateDoItSucess <T extends Object> extends BaseStateDoIt {

  final T data;

  BaseStateDoItSucess({required this.data});


}