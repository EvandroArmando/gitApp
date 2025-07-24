abstract class Result<T > {
  const Result();

  factory Result.ok(T value) = Ok._;
  factory Result.error(Exception error) = Error._;
}

final class Ok<T > extends Result<T> {
  final T value;
  Ok._(this.value);
}

final class Error<T > extends Result<T> {
  final Exception error;
  Error._(this.error);
}

extension ok on Object {
  Result parseOK() {
    return Result.ok(this);
  }
}

extension error on Object {
  Result parseError() {
    return Result.error(this as Exception);
  }
}

extension ResultCasting<T > on Result<T> {
  Ok<T> get asOk => this as Ok <T>;
}
