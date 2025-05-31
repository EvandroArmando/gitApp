import '../Controller/state_observer_teste.dart';

extension ReactivePrimitives on int {
  StateObserverteste<int> obs() {
    return StateObserverteste<int>(this);
  }
}

extension ReactivePrimitivesDouble on double {
  StateObserverteste<double> obs() {
    return StateObserverteste<double>(this);
  }
}

extension ReactivePrimitivesString on String {
  StateObserverteste<String> obs() {
    return StateObserverteste<String>(this);
  }
}

extension ReativePrimitiveBolean on bool {
  StateObserverteste<bool> obs() {
    return StateObserverteste(this);
  }
}
