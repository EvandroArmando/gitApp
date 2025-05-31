
import '../entities/base_state.dart';
import '../entities/error_state.dart';
import '../entities/initial_state.dart';
import '../entities/loading_state.dart';
import '../entities/products.dart';
import '../entities/sucess_state.dart';
import 'state_observer_teste.dart';

class ProductController extends StateObserverteste<BaseState> {
ProductController() : super(InitialState());
  loadState() {
    state = LoadingState();
    state = SuccessState(
      data: [
        Products('Produto 1', 'Produto 1'),
        Products('Produto 1', 'Produto 1'),
        Products('Produto 1', 'Produto 1'),
      ],
    );
  }
  generateError() {
    state = LoadingState();
    try {
      throw Exception();
    } catch (e) {
      state = ErrorState(message: e.toString());
    }
  }
}