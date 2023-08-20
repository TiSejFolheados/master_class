sealed class FibonacciState {
  final int? termos;

  FibonacciState(this.termos);

  FibonacciState.state(FibonacciState state) : this(state.termos);

  bool get isValidTermos => termos != null;

  bool get isValidTermosSize => isValidTermos && termos! > 0 && termos! < 94;
}

class FibonacciStateInit extends FibonacciState {
  FibonacciStateInit(super.termos);

  FibonacciStateInit.init() : super(null);
}

class FibonacciStateValidationError extends FibonacciState {
  FibonacciStateValidationError(FibonacciState state) : super.state(state);
}

class FibonacciStateLoading extends FibonacciState {
  FibonacciStateLoading(FibonacciState state) : super.state(state);
}

class FibonacciStateResult extends FibonacciState {
  final List<int> sequencia;

  FibonacciStateResult(FibonacciState state, this.sequencia) : super.state(state);

  String get sequenciaText {
    String result = "";
    int termo = 1;
    for (var value in sequencia) {
      if (termo != 1) {
        result += "\n";
      }
      result += "${termo++} - $value";
    }

    return result;
  }
}
